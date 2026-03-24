import UIKit

final class HapticManager {

    static let shared = HapticManager()

    private init() {}

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
