import Foundation
import Combine

final class MainTabBarAppearanceManager: ObservableObject {
    
    static var instance = MainTabBarAppearanceManager()
    
    @Published var hasTabBar = true
    
    private init() {}
}
