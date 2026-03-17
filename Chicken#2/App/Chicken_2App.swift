import SwiftUI

@main
struct Chicken_2App: App {
    
    @AppStorage("onboardingEnd") var onboardingEnd = false
    
    var body: some Scene {
        WindowGroup {
            if onboardingEnd {
                MainTabRootView()
            } else {
                OnboardingRootView()
            }
        }
    }
}

