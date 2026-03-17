import SwiftUI

struct PhotoFrameView: View {

    var size: CGFloat = 250
    var cornerLength: CGFloat = 40
    var lineWidth: CGFloat = 4
    var cornerRadius: CGFloat = 16

    var body: some View {
        Canvas { context, canvasSize in
            let w = canvasSize.width
            let h = canvasSize.height
            let r = cornerRadius
            let l = cornerLength

            let topLeft: Path = {
                var p = Path()
                p.move(to: CGPoint(x: 0, y: r + l))
                p.addLine(to: CGPoint(x: 0, y: r))
                p.addQuadCurve(to: CGPoint(x: r, y: 0),
                               control: CGPoint(x: 0, y: 0))
                p.addLine(to: CGPoint(x: r + l, y: 0))
                return p
            }()

            let topRight: Path = {
                var p = Path()
                p.move(to: CGPoint(x: w - r - l, y: 0))
                p.addLine(to: CGPoint(x: w - r, y: 0))
                p.addQuadCurve(to: CGPoint(x: w, y: r),
                               control: CGPoint(x: w, y: 0))
                p.addLine(to: CGPoint(x: w, y: r + l))
                return p
            }()

            let bottomRight: Path = {
                var p = Path()
                p.move(to: CGPoint(x: w, y: h - r - l))
                p.addLine(to: CGPoint(x: w, y: h - r))
                p.addQuadCurve(to: CGPoint(x: w - r, y: h),
                               control: CGPoint(x: w, y: h))
                p.addLine(to: CGPoint(x: w - r - l, y: h))
                return p
            }()

            let bottomLeft: Path = {
                var p = Path()
                p.move(to: CGPoint(x: r + l, y: h))
                p.addLine(to: CGPoint(x: r, y: h))
                p.addQuadCurve(to: CGPoint(x: 0, y: h - r),
                               control: CGPoint(x: 0, y: h))
                p.addLine(to: CGPoint(x: 0, y: h - r - l))
                return p
            }()

            let style = StrokeStyle(lineWidth: lineWidth, lineCap: .round)
            for path in [topLeft, topRight, bottomRight, bottomLeft] {
                context.stroke(path, with: .color(.white), style: style)
            }
        }
        .frame(width: size, height: size)
        .allowsHitTesting(false)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PhotoFrameView()
    }
}
