import SwiftUI

struct ChickenDetailView: View {
    
    @ObservedObject var viewModel: ChickensViewModel
    
    @State var chicken: ChickenBreed
    
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
    }
    
    private var backgroundImage: some View {
        Image(chicken.icon)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width)
            .frame(maxHeight: 400, alignment: .top)
            .clipped()
    }
    
    private var breed: some View {
        VStack(spacing: 8) {
            HStack {
                Text(chicken.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.interFont(size: 32, weight: .regular))
                    .foregroundStyle(.white)
                
                let isFavorite = viewModel.favoritesChicken.contains(chicken)
                
                Button {
                    viewModel.toggleFavorite(of: chicken)
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.mainOrange)
                }
                .frame(width: 44, height: 44)
            }
            
            HStack {
                Text(chicken.rarity.title)
                    .frame(height: 25)
                    .padding(.horizontal)
                    .background(chicken.color)
                    .foregroundStyle(.white)
                    .cornerRadius(100)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var description: some View {
        Text(chicken.description)
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
                        
                        Text(chicken.averageLifespanYears.formatted() + " Years")
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
                        
                        Text("\(chicken.averagePriceUSD.formatted())$")
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
                        
                        Text(chicken.eggsPerWeek.formatted() + "/week")
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
                        
                        Text(chicken.rarity.title)
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

#Preview {
    ChickenDetailView(viewModel: ChickensViewModel(), chicken: .australorp)
}
