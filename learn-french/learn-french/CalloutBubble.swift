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
            BubbleShape(arrowDirection: anchor.arrowDirection)
                .fill(Color(.systemBackground))
                .overlay(
                    BubbleShape(arrowDirection: anchor.arrowDirection)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                )
                .shadow(radius: 6, x: 0, y: 2)
        )
    
    }

    private func bubbleOffset() -> CGSize {
        // Position the bubble so the arrow points to the anchor point
        let bubbleWidth: CGFloat = min(220, UIScreen.main.bounds.width - 40) // Responsive width
        let bubbleHeight: CGFloat = 70

        let x = anchor.point.x - bubbleWidth/2
        
        // Position based on arrow direction - minimal gap
        let y: CGFloat
        if anchor.arrowDirection == .down {
            // Arrow points down, so position bubble above the anchor point
            y = anchor.point.y - bubbleHeight - 1
        } else {
            // Arrow points up, so position bubble below the anchor point
            y = anchor.point.y + 1
        }

        return CGSize(width: x, height: y)
    }
}

struct BubbleShape: Shape {
    let arrowDirection: CalloutAnchor.Arrow
    
    init(arrowDirection: CalloutAnchor.Arrow = .up) {
        self.arrowDirection = arrowDirection
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let r: CGFloat = 12
        let arrowWidth: CGFloat = 12
        let arrowHeight: CGFloat = 8

        // Main rounded rectangle
        p.addRoundedRect(in: rect, cornerSize: CGSize(width: r, height: r))
        
        // Add arrow based on direction
        let centerX = rect.midX
        
        if arrowDirection == .up {
            // Arrow pointing up (below the bubble)
            let arrowY = rect.maxY
            let arrowLeft = centerX - arrowWidth/2
            let arrowRight = centerX + arrowWidth/2
            
            p.move(to: CGPoint(x: arrowLeft, y: arrowY))
            p.addLine(to: CGPoint(x: centerX, y: arrowY + arrowHeight))
            p.addLine(to: CGPoint(x: arrowRight, y: arrowY))
        } else {
            // Arrow pointing down (above the bubble)
            let arrowY = rect.minY
            let arrowLeft = centerX - arrowWidth/2
            let arrowRight = centerX + arrowWidth/2
            
            p.move(to: CGPoint(x: arrowLeft, y: arrowY))
            p.addLine(to: CGPoint(x: centerX, y: arrowY - arrowHeight))
            p.addLine(to: CGPoint(x: arrowRight, y: arrowY))
        }
        
        return p
    }
} 