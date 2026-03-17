import SwiftUI

enum InterFontWeight: String {
    case regular = "Inter-Regular"
    case medium = "Inter-Medium"
    case semibold = "Inter-SemiBold"
    case bold = "Inter-Bold"
}

extension Font {
    static func interFont(size: CGFloat, weight: InterFontWeight) -> Font {
        .custom(weight.rawValue, size: size)
    }
}
