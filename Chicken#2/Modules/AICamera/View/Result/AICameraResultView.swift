import SwiftUI

struct AICameraResultView: View {
    
    @Environment(\.dismiss) var dismiss 
    
    @StateObject private var viewModel = CameraResultViewModel()
    
    @State var model: ChickenUIResponseModel
    
    @State private var isFavorite = false
    
    var body: some View {
        ZStack {
            Color.mainBG
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    backgroundImage
                    
                    VStack(spacing: 16) {
                        breed
                        description
                        detailedInfo
                    }
                    .padding(.horizontal, 16)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            MainTabBarAppearanceManager.instance.hasTabBar = false
            isFavorite = model.isFavorite
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.save(model)
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(.black)
                }
            }
        }
        .onChange(of: viewModel.shouldClose) { shouldClose in
            if shouldClose {
                dismiss()
            }
        }
    }
 
    private var backgroundImage: some View {
        Image(uiImage: model.image)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width)
            .frame(maxHeight: 400, alignment: .top)
            .clipped()
    }
    
    private var breed: some View {
        VStack(spacing: 8) {
            HStack {
                Text(model.response?.breed ?? "N/A")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.interFont(size: 32, weight: .regular))
                    .foregroundStyle(.white)
                
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.mainOrange)
                }
                .frame(width: 44, height: 44)
            }
            
            HStack {
                Text(model.response?.rarity ?? "N/A")
                    .frame(height: 25)
                    .padding(.horizontal)
                    .background(.white)
                    .foregroundStyle(.black)
                    .cornerRadius(100)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var description: some View {
        Text(model.response?.description ?? "N/A")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .font(.interFont(size: 18, weight: .regular))
            .foregroundStyle(Color(hex: "#9E9E9E"))
            .background(Color(hex: "#474747"))
            .cornerRadius(8)
    }
    
    private var detailedInfo: some View {
        VStack {
            HStack {
                VStack(spacing: 4) {
                    Text("Life expectancy:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.interFont(size: 14, weight: .regular))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    HStack {
                        Image(.Images.Detail.year)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        Text((model.response?.lifeExpectancy.formatted() ?? "N/A") + " Years")
                            .font(.interFont(size: 18, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 76)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .background(Color(hex: "#474747"))
                .cornerRadius(8)
                
                VStack(spacing: 4) {
                    Text("Avg. price:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.interFont(size: 14, weight: .regular))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    HStack {
                        Image(.Images.Detail.price)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        Text("\(model.response?.avgPrice.formatted() ?? "N/A")$")
                            .font(.interFont(size: 18, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 76)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .background(Color(hex: "#474747"))
                .cornerRadius(8)
            }
            
            HStack {
                VStack(spacing: 4) {
                    Text("Laying rate:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.interFont(size: 14, weight: .regular))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    HStack {
                        Image(.Images.Detail.egg)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        Text((model.response?.layingRate.formatted() ?? "N/A") + "/week")
                            .font(.interFont(size: 18, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 76)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .background(Color(hex: "#474747"))
                .cornerRadius(8)
                
                VStack(spacing: 4) {
                    Text("Rarity:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.interFont(size: 14, weight: .regular))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    HStack {
                        Image(.Images.Detail.price)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        Text(model.response?.rarity ?? "N/A")
                            .font(.interFont(size: 18, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 76)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .background(Color(hex: "#474747"))
                .cornerRadius(8)
            }
        }
        .foregroundStyle(.white)
    }
}
