import SwiftUI

struct ChickensRootView: View {
    
    @StateObject private var viewModel = ChickensViewModel()
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
            ZStack {
                Color.mainBG
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    navigation
                    chickens
                }
            }
            .animation(.smooth, value: viewModel.chickens)
            .animation(.smooth, value: viewModel.scannedChickens)
            .navigationDestination(for: ChickenScreen.self) { screen in
                switch screen {
                    case .detail(let chicken):
                        ChickenDetailView(viewModel: viewModel, chicken: chicken)
                    case .scannedDetail(let model):
                        AICameraResultView(model: model)
                }
            }
            .onAppear {
                viewModel.loadFavorites()
                MainTabBarAppearanceManager.instance.hasTabBar = true 
            }
        }
    }
    
    private var navigation: some View {
        VStack {
            HStack(spacing: 0) {
                Text("Chicken")
                    .foregroundStyle(.white)
                
                Text("Pedia")
                    .foregroundStyle(.mainOrange)
                
                Spacer()
                
                Button {
                    viewModel.toggleFavorite()
                } label: {
                    Image(systemName: viewModel.favoriteOn ? "heart.fill" : "heart")
                        .font(.system(size: 26, weight: .medium))
                        .foregroundStyle(viewModel.favoriteOn ? .mainOrange : .white)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.interFont(size: 36, weight: .semibold))
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(.white.opacity(0.5))
                
                TextField("", text: $viewModel.searchText, prompt: Text("Search Breed...")
                    .foregroundColor(Color(hex: "#797979"))
                )
                .font(.interFont(size: 18, weight: .regular))
                .foregroundStyle(.white)
                .focused($isFocused)
                
                if viewModel.searchText != "" {
                    Button {
                        isFocused = false
                        viewModel.searchText = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                }
            }
            .frame(height: 48)
            .padding(.horizontal, 12)
            .background(Color(hex: "#474747"))
            .cornerRadius(8)
        }
        .padding(.top)
        .padding(.horizontal, 16)
    }
    
    private var chickens: some View {
        ScrollView(showsIndicators: false) {
            if !viewModel.scannedChickens.isEmpty {
                VStack {
                    Text("Scanned breeds:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                        .foregroundStyle(.white)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 8), count: 2), spacing: 8) {
                        ForEach(viewModel.scannedChickens) { model in
                            Button {
                                MainTabBarAppearanceManager.instance.hasTabBar = false
                                viewModel.navPath.append(.scannedDetail(model))
                            } label: {
                                VStack {
                                    Image(uiImage: model.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: (UIScreen.main.bounds.width - 40) / 2, height: 100)
                                        .clipped()
                                    
                                    VStack(spacing: 4) {
                                        Text(model.response?.breed ?? "N/A")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.interFont(size: 18, weight: .regular))
                                            .foregroundStyle(.white)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.8)
                                        
                                        Text(model.response?.rarity ?? "N/A")
                                            .frame(height: 24)
                                            .padding(.horizontal, 6)
                                            .font(.interFont(size: 18, weight: .regular))
                                            .foregroundStyle(.black)
                                            .background(.white)
                                            .cornerRadius(100)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 8)
                                }
                                .background(Color(hex: "#474747"))
                                .cornerRadius(24)
                                .overlay(alignment: .topTrailing) {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.black.opacity(0.5))
                                        .padding(10)
                                        .overlay {
                                            Button {
                                                viewModel.toggleFavorite(of: model)
                                            } label: {
                                                Image(systemName: model.isFavorite ? "heart.fill" : "heart")
                                                    .font(.system(size: 18, weight: .medium))
                                                    .foregroundStyle(.orange)
                                            }
                                        }
                                }
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    viewModel.remove(model)
                                } label: {
                                    Label("Remove chicken", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            if !viewModel.chickens.isEmpty {
                VStack {
                    Text("Default breeds:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                        .foregroundStyle(.white)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 8), count: 2), spacing: 8) {
                        ForEach(viewModel.chickens) { breed in
                            Button {
                                MainTabBarAppearanceManager.instance.hasTabBar = false
                                viewModel.navPath.append(.detail(breed))
                            } label: {
                                VStack {
                                    Image(breed.icon)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: (UIScreen.main.bounds.width - 40) / 2, height: 100)
                                        .clipped()
                                    
                                    VStack(spacing: 4) {
                                        Text(breed.name)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.interFont(size: 18, weight: .regular))
                                            .foregroundStyle(.white)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.8)
                                        
                                        Text(breed.rarity.title)
                                            .frame(height: 24)
                                            .padding(.horizontal, 6)
                                            .font(.interFont(size: 18, weight: .regular))
                                            .foregroundStyle(.white)
                                            .background(breed.color)
                                            .cornerRadius(100)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 8)
                                }
                                .background(Color(hex: "#474747"))
                                .cornerRadius(24)
                                .overlay(alignment: .topTrailing) {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.black.opacity(0.5))
                                        .padding(10)
                                        .overlay {
                                            let isFavorite = viewModel.favoritesChicken.contains(breed)
                                            
                                            Button {
                                                viewModel.toggleFavorite(of: breed)
                                            } label: {
                                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                                    .font(.system(size: 18, weight: .medium))
                                                    .foregroundStyle(.orange)
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            Color.clear
                .frame(height: 70)
        }
    }
}

#Preview {
    ChickensRootView()
}

