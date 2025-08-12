import SwiftUI

struct CalloutAnchor {
    enum Arrow { case up, down }
    var point: CGPoint      // where the arrow tip should point (in container coords)
    var arrowDirection: Arrow
}

struct CalloutBubble: View {
    let title: String
    let subtitle: String
    let anchor: CalloutAnchor
    let onClose: () -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Position the whole callout relative to the anchor
            bubble
                .fixedSize()
                .alignmentGuide(.top) { _ in 0 }
                .overlay(alignment: .topLeading) { EmptyView() }
                .offset(bubbleOffset())
        }
        .allowsHitTesting(true)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Translation for '\(title)': \(subtitle)")
        .accessibilityHint("Double tap to close")
    }

    @ViewBuilder
    private var bubble: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.blue)
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: min(220, UIScreen.main.bounds.width - 40))
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(
            BubbleShape()
                .fill(Color(.systemBackground))
                .overlay(
                    BubbleShape()
                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                )
                .shadow(radius: 6, x: 0, y: 2)
        )
    
    }

    private func bubbleOffset() -> CGSize {
        // The bubble's origin so it's centered on the anchor point
        let bubbleWidth: CGFloat = min(220, UIScreen.main.bounds.width - 40) // Responsive width
        let bubbleHeight: CGFloat = 70

        let x = anchor.point.x - bubbleWidth/2
        let y = anchor.point.y - bubbleHeight/2

        return CGSize(width: x, height: y)
    }
}

struct BubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let r: CGFloat = 12

        // Simple rounded rectangle without arrow
        p.addRoundedRect(in: rect, cornerSize: CGSize(width: r, height: r))
        
        return p
    }
} 