import SwiftUI
import UIKit

final class ClickableTextView: UITextView, UITextViewDelegate {
    var onWordTap: ((String, CGRect, CGSize) -> Void)?
    var onBubbleDismiss: (() -> Void)?

    private let wordRegex = try! NSRegularExpression(
        pattern: #"(?:[\p{L}']+)"#, options: []
    )

    init(text: String) {
        super.init(frame: .zero, textContainer: nil)
        isEditable = false
        isScrollEnabled = true
        backgroundColor = .clear
        delegate = self
        textContainerInset = .zero
        contentInset = .zero
        linkTextAttributes = [.foregroundColor: UIColor.label] // we'll style via highlight

        attributedText = makeLinkedAttributedString(text)
    }
    required init?(coder: NSCoder) { fatalError() }

    private func makeLinkedAttributedString(_ text: String) -> NSAttributedString {
        // Tokenize and add a custom URL per word; spaces/punct kept raw
        let full = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.preferredFont(forTextStyle: .title2)
        ])
        let ns = text as NSString
        wordRegex.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: ns.length)) { m, _, _ in
            guard let r = m?.range else { return }
            let word = ns.substring(with: r)
            if let url = URL(string: "word:///\(word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)") {
                full.addAttribute(.link, value: url, range: r)
            }
        }
        return full
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // Make sure taps near text still register
        let insetBounds = bounds.insetBy(dx: -8, dy: -8)
        return insetBounds.contains(point)
    }

    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        guard URL.scheme == "word" else { return true }
        let word = URL.lastPathComponent.removingPercentEncoding ?? ""

        // Compute rect for the tapped range (convert to view coords)
        guard let layoutManager = textView.layoutManager as NSLayoutManager?,
              let textContainer = textView.textContainer as NSTextContainer? else { return false }

        let glyphRange = layoutManager.glyphRange(forCharacterRange: characterRange, actualCharacterRange: nil)
        var rect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)

        // Convert from textContainer to view coordinates
        rect.origin.x += textContainerInset.left - contentOffset.x
        rect.origin.y += textContainerInset.top  - contentOffset.y

        // Add a little vertical offset so the bubble sits above the word
        rect = rect.insetBy(dx: -2, dy: -1)

        // Temporary highlight
        let mutable = attributedText.mutableCopy() as! NSMutableAttributedString
        mutable.removeAttribute(.backgroundColor, range: NSRange(location: 0, length: mutable.length))
        mutable.addAttribute(.backgroundColor, value: UIColor.systemYellow.withAlphaComponent(0.35), range: characterRange)
        attributedText = mutable

        // Add haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
        
        onWordTap?(word, rect, bounds.size)
        return false
    }
    

}

struct ClickableTextRepresentable: UIViewRepresentable {
    let text: String
    let onWordTap: (String, CGRect, CGSize) -> Void

    func makeUIView(context: Context) -> ClickableTextView {
        let v = ClickableTextView(text: text)
        v.onWordTap = onWordTap
        return v
    }
    
    func updateUIView(_ uiView: ClickableTextView, context: Context) {}
} 