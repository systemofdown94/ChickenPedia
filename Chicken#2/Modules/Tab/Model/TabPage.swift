import UIKit

enum TabPage: Identifiable, CaseIterable {
    case chickens
    case camera
    case settings
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
            case .camera:
                "AI Camera"
            case .chickens:
                "Chickens"
            case .settings:
                "Settings"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .chickens:
                    .Images.Tab.chickens
            case .camera:
                    .Images.Tab.aiCamera
            case .settings:
                    .Images.Tab.settings
        }
    }
}
