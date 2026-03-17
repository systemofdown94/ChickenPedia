import UIKit

enum OnboardingPage: Int, Identifiable {
    case page1 = 0
    case page2
    case page3
    case page4
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
            case .page1:
                "Discover Chicken\nBreeds"
            case .page2:
                "Detailed\nInformation"
            case .page3:
                "AI Chicken\nIdnentifer"
            case .page4:
                "Save Your\nFavorites"
        }
    }
    
    var subtitle: String {
        switch self {
            case .page1:
                "Explore dozens of chicken\nbreeds from around the world."
            case .page2:
                "Learn about lifespan, egg\nproduction and breed rarity."
            case .page3:
                "Take a photo and let AI\nidentify the breed instantly."
            case .page4:
                "Kepp track of the breeds you\nlike the most."
        }
    }
    
    var image: ImageResource {
        switch self {
            case .page1:
                    .Images.Onboarding.onb1
            case .page2:
                    .Images.Onboarding.onb2
            case .page3:
                    .Images.Onboarding.onb3
            case .page4:
                    .Images.Onboarding.onb4
        }
    }
}
