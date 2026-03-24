import SwiftUI

struct MainTabRootView: View {
    
    @ObservedObject private var appearanceManager = MainTabBarAppearanceManager.instance
    
    @State private var page: TabPage = .chickens
    
    init() {
        UITabBar.appearance().isHidden = false
    }
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                TabView(selection: $page) {
                    ChickensRootView()
                        .tag(TabPage.chickens)
                        .toolbar(.hidden, for: .tabBar)
                    
                    AICameraRootView()
                        .tag(TabPage.camera)
                        .toolbar(.hidden, for: .tabBar)
                    
                    SettingsRootView()
                        .tag(TabPage.settings)
                        .toolbar(.hidden, for: .tabBar)
                }
                
                tabBar
            }
        }
        .ignoresSafeArea(.keyboard)
    }
    
    private var tabBar: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color(hex: "#9E9E9E"))
            
            HStack {
                ForEach(TabPage.allCases) { page in
                    Button {
                        HapticManager.shared.impact()
                        self.page = page
                    } label: {
                        VStack {
                            VStack {
                                Image(page.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 38, height: 38)
                            }
                            
                            Text(page.title)
                                .frame(maxWidth: .infinity)
                                .font(.interFont(size: 18, weight: .regular))
                        }
                        .foregroundStyle(self.page == page ? .mainOrange : Color(hex: "#9E9E9E"))
                    }
                }
            }
            .frame(height: 80)
            .background(Color(hex: "#474747"))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .opacity(appearanceManager.hasTabBar ? 1 : 0)
        .animation(.default, value: appearanceManager.hasTabBar)
    }
}

#Preview {
    MainTabRootView()
}
