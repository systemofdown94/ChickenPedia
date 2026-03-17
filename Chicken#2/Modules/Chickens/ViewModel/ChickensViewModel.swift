import Foundation
import Combine

final class ChickensViewModel: ObservableObject {
    
    private let storage = LocalStorageManager.instance
    
    @Published var searchText = ""
    
    @Published var navPath: [ChickenScreen] = []
    
    @Published private(set) var chickens: [ChickenBreed] = ChickenBreed.allCases
    @Published private(set) var favoritesChicken: [ChickenBreed] = []
    
    @Published private(set) var favoriteOn = false
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        observeSearchText()
        observeFavoriteToggle()
    }
    
    func toggleFavorite() {
        favoriteOn.toggle()
    }
    
    func toggleFavorite(of chicken: ChickenBreed) {
        Task {
            var favorites = await storage.fetch([ChickenBreed].self, for: .chickens) ?? []
            
            if let storageIndex = favorites.firstIndex(where: { $0.rawValue == chicken.rawValue }) {
                favorites.remove(at: storageIndex)
            } else {
                favorites.append(chicken)
            }
            
            await storage.store(favorites, key: .chickens)
            
            await MainActor.run {
                if let index = favoritesChicken.firstIndex(where: { $0.rawValue == chicken.rawValue }) {
                    favoritesChicken.remove(at: index)
                } else {
                    favoritesChicken.append(chicken)
                }
            }
        }
    }
    
    func loadFavorites() {
        Task {
            let favorites = await storage.fetch([ChickenBreed].self, for: .chickens) ?? []
            
            await MainActor.run {
                self.favoritesChicken = favorites
            }
        }
    }
    
    private func observeSearchText() {
        $searchText
            .sink { [weak self] text in
                guard let self,
                      text != "" else {
                    self?.chickens = ChickenBreed.allCases
                    return
                }
                
                self.chickens = ChickenBreed.allCases.filter { $0.name.contains(text )}
            }
            .store(in: &cancellable)
    }
    
    private func observeFavoriteToggle() {
        $favoriteOn
            .sink { [weak self] isOn in
                guard let self else { return }
                self.chickens = ChickenBreed.allCases.filter { isOn ? self.favoritesChicken.contains($0) : true }
            }
            .store(in: &cancellable)
    }
}
