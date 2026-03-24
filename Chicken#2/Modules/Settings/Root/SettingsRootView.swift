import SwiftUI

struct SettingsRootView: View {
    
    @AppStorage("hasNotification") var hasNotification = false
    
    @State private var hasToggle = false
    @State private var showPushAlert = false
    @State private var showRemoveAlert = false
    @State private var showPrivacy = false
    
    var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var body: some View {
        ZStack {
            Color.mainBG
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                navigationBar
                
                VStack(spacing: 32) {
                    Button {
                        showPrivacy = true
                        MainTabBarAppearanceManager.instance.hasTabBar = false
                    } label: {
                        HStack {
                            Image(systemName: "shield.pattern.checkered")
                                .font(.system(size: 48, weight: .medium))
                            
                            Text("Privacy Policy")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.interFont(size: 21, weight: .regular))
                            
                            Image(systemName: "chevron.forward")
                                .font(.system(size: 32, weight: .medium))
                        }
                        .frame(height: 60)
                    }
                    
//                    Rectangle()
//                        .frame(height: 1)
//                        .opacity(0.5)
//                    
//                    HStack {
//                        Image(systemName: "bell.circle.fill")
//                            .font(.system(size: 48, weight: .medium))
//                        
//                        Text("Push notification")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .font(.interFont(size: 21, weight: .regular))
//                        
//                        Image(systemName: "chevron.forward")
//                            .font(.system(size: 32, weight: .medium))
//                    }
//                    .frame(height: 60)
                    
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.5)
                    
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 48, weight: .medium))
                        
                        Text("App Version:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.interFont(size: 21, weight: .regular))
                        
                        Text(version)
                            .font(.interFont(size: 21, weight: .bold))
                    }
                    .frame(height: 60)
                    
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.5)
                    
                    Button {
                        showRemoveAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "externaldrive.badge.minus")
                                .font(.system(size: 48, weight: .medium))
                            
                            Text("Remove data")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.interFont(size: 21, weight: .regular))
                        }
                        .frame(height: 60)
                    }
                }
                .padding(.horizontal, 16)
                .foregroundStyle(.white)
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            
            if showPrivacy {
                if let url = URL(string: "https://chickenscanner.online/privacy-policy") {
                    VStack(spacing: 0) {
                        HStack {
                            Button {
                                showPrivacy = false
                                MainTabBarAppearanceManager.instance.hasTabBar = true
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .frame(width: 44, height: 44)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        BlackWindow(url: url, isHidden: .constant(false))
                            .ignoresSafeArea(edges: .bottom)
                    }
                    .background(
                        Color.mainBG
                    )
                }
            }
        }
        .animation(.default, value: showPrivacy)
        .alert("Are you sure you want to delete all the data", isPresented: $showRemoveAlert) {
            Button("Yes", role: .destructive) {
                Task {
                    LocalStorageManager.instance.clear(.chickens)
                }
            }
        }
    }
    
    private var navigationBar: some View {
        VStack(spacing: 0) {
            Text("Settings")
                .frame(height: 80)
                .font(.interFont(size: 36, weight: .semibold))
                .foregroundStyle(.white)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color(hex: "#9E9E9E"))
        }
    }
}

#Preview {
    SettingsRootView()
}
