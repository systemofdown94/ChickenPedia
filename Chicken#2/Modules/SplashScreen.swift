import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.mainBG
                .ignoresSafeArea()
            
            Image(.Images.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashScreen()
}
