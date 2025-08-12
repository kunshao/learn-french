import SwiftUI
import UIKit

struct DuoStyleReader: View {
    let text: String
    let translate: (String) async -> String

    @State private var tappedWord: String?
    @State private var translation: String = ""
    @State private var targetRect: CGRect = .zero
    @State private var viewSize: CGSize = .zero
    @State private var showBubble = false

    var body: some View {
        ZStack {
            ClickableTextRepresentable(
                text: text,
                onWordTap: { word, rect, containerSize in
                    tappedWord = word
                    targetRect = rect
                    viewSize = containerSize
                    showBubble = true
                    Task {
                        translation = await translate(word)
                    }
                }
            )
            .id("clickable-text-\(text.hashValue)")
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onChange(of: proxy.size) { new in viewSize = new }
                        .onAppear { viewSize = proxy.size }
                }
            )

            if showBubble, let word = tappedWord {
                CalloutBubble(
                    title: word,
                    subtitle: translation.isEmpty ? "…" : translation,
                    anchor: adjustedAnchor(rect: targetRect, in: viewSize),
                    onClose: { 
                        showBubble = false
                        // Clear highlight when bubble is dismissed
                        tappedWord = nil
                    }
                )
                .transition(.opacity.combined(with: .scale))
                .animation(.spring(response: 0.25, dampingFraction: 0.9), value: showBubble)
            }
        }
        .padding()
        .onTapGesture {
            // tap outside to dismiss
            if showBubble { showBubble = false }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            // Close bubble when app backgrounds
            showBubble = false
        }
    }

    /// Keeps the bubble on-screen (simple clamp + flip below if near top).
    private func adjustedAnchor(rect: CGRect, in container: CGSize) -> CalloutAnchor {
        let padding: CGFloat = 8
        let preferred = CGPoint(x: rect.midX, y: rect.minY)
        var point = preferred

        // horizontal clamp
        point.x = max(padding, min(container.width - padding, point.x))

        // If too close to the top, flip arrow to point downward
        let showBelow = rect.minY < 60

        return CalloutAnchor(
            point: point,
            arrowDirection: showBelow ? .down : .up
        )
    }
} 