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
            BubbleShape(arrow: anchor.arrowDirection)
                .fill(Color(.systemBackground))
                .overlay(
                    BubbleShape(arrow: anchor.arrowDirection)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                )
                .shadow(radius: 6, x: 0, y: 2)
        )
    
    }

    private func bubbleOffset() -> CGSize {
        // The bubble's origin so its arrow tip meets `anchor.point`.
        let bubbleWidth: CGFloat = min(220, UIScreen.main.bounds.width - 40) // Responsive width
        let bubbleHeight: CGFloat = 70
        let arrowH: CGFloat = 8

        let x = anchor.point.x - bubbleWidth/2
        let y = anchor.arrowDirection == .up
            ? (anchor.point.y - bubbleHeight - arrowH)
            : (anchor.point.y + arrowH)

        return CGSize(width: x, height: y)
    }
}

struct BubbleShape: Shape {
    let arrow: CalloutAnchor.Arrow

    func path(in rect: CGRect) -> Path {
        var p = Path()
        let r: CGFloat = 12
        let arrowW: CGFloat = 16
        let arrowH: CGFloat = 8

        let top = arrow == .up
        let bottom = arrow == .down

        // Rounded rect
        let body = CGRect(
            x: rect.minX,
            y: top ? rect.minY + arrowH : rect.minY,
            width: rect.width,
            height: rect.height - arrowH
        )
        p.addRoundedRect(in: body, cornerSize: CGSize(width: r, height: r))

        // Arrow centered on top/bottom
        let midX = rect.midX
        if top {
            p.move(to: CGPoint(x: midX - arrowW/2, y: body.minY))
            p.addLine(to: CGPoint(x: midX, y: body.minY - arrowH))
            p.addLine(to: CGPoint(x: midX + arrowW/2, y: body.minY))
            p.closeSubpath()
        } else if bottom {
            p.move(to: CGPoint(x: midX - arrowW/2, y: body.maxY))
            p.addLine(to: CGPoint(x: midX, y: body.maxY + arrowH))
            p.addLine(to: CGPoint(x: midX + arrowW/2, y: body.maxY))
            p.closeSubpath()
        }
        return p
    }
} 