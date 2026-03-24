import SwiftUI
import StoreKit

struct OnboardingRootView: View {
    
    @AppStorage("onboardingEnd") var onboardingEnd = false
    
    @State private var page: OnboardingPage = .page1
    
    var body: some View {
        ZStack {
            Color.mainBG
                .ignoresSafeArea()
            
            image
            
            VStack(spacing: 16) {
                title
                subtitle
            }
            .padding(.top, 50)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            
            VStack {
                VStack(spacing: 16) {
                    HStack(spacing: 10) {
                        ForEach(0..<4, id: \.self) { index in
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(index == page.rawValue ? .mainOrange : Color(hex: "#696969"))
                        }
                    }
                    
                    Button {
                        HapticManager.shared.impact()
                        
                        withAnimation {
                            if page == .page4 {
                                onboardingEnd = true
                            } else {
                                page = OnboardingPage(rawValue: page.rawValue + 1) ?? .page1
                                
                                if page == .page3 {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                            SKStoreReviewController.requestReview(in: scene)
                                        }
                                    }
                                }
                            }
                        }
                    } label: {
                        Text("Continue")
                            .frame(width: 270, height: 52)
                            .font(.interFont(size: 19, weight: .bold))
                            .background(.mainOrange)
                            .foregroundStyle(.white)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 60)
        }
    }
    
    private var image: some View {
        VStack {
            Image(page.image)
                .resizable()
                .scaledToFill()
                .frame(height: 430)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
    
    private var title: some View {
        Text(page.title)
            .font(.interFont(size: 36, weight: .semibold))
    }
    
    private var subtitle: some View {
        Text(page.subtitle)
            .font(.interFont(size: 18, weight: .regular))
            .foregroundStyle(Color(hex: "#9E9E9E"))
    }
}

#Preview {
    OnboardingRootView()
}
