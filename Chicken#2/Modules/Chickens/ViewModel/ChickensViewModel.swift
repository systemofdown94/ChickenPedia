import Foundation
import Combine

final class ChickensViewModel: ObservableObject {
    
    private let storage = LocalStorageManager.instance
    private let imageStorage = ImageDiskRepository.instance
    
    @Published var searchText = ""
    
    @Published var navPath: [ChickenScreen] = []
    
    @Published private(set) var chickens: [ChickenBreed] = ChickenBreed.allCases
    @Published private(set) var scannedChickens: [ChickenUIResponseModel] = []
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
    
    func remove(_ model: ChickenUIResponseModel) {
        Task {
            var favorites = await storage.fetch([ChickenResponseModelDTO].self, for: .newChicken) ?? []
            
            if let index = favorites.firstIndex(where: { $0.id == model.id }) {
                favorites.remove(at: index)
            }
            
            await storage.store(favorites, key: .newChicken)
            
            await MainActor.run {
                if let uiIndex = self.scannedChickens.firstIndex(where: { $0.id == model.id }) {
                    self.scannedChickens.remove(at: uiIndex)
                }
            }
        }
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
    
    func toggleFavorite(of scannedChicken: ChickenUIResponseModel) {
        Task {
            var favorites = await storage.fetch([ChickenResponseModelDTO].self, for: .newChicken) ?? []
            
            if let storageIndex = favorites.firstIndex(where: { $0.id == scannedChicken.id }) {
                favorites[storageIndex].isFavorite.toggle()
            }
            
            await storage.store(favorites, key: .newChicken)
            
            await MainActor.run {
                if let index = scannedChickens.firstIndex(where: { $0.id == scannedChicken.id }) {
                    self.scannedChickens[index].isFavorite.toggle()
                }
            }
        }
    }
    
    func loadFavorites() {
        Task {
            let favorites = await storage.fetch([ChickenBreed].self, for: .chickens) ?? []
            let newChickens = await storage.fetch([ChickenResponseModelDTO].self, for: .newChicken) ?? []
            
            let resultWithImages = await withTaskGroup(of: ChickenUIResponseModel?.self) { group in
                for chicken in newChickens {
                    group.addTask {
                        guard let image = await self.imageStorage.fetchImage(id: chicken.id) else { return nil }
                        return ChickenUIResponseModel(id: chicken.id, image: image, response: chicken.response, isFavorite: chicken.isFavorite)
                    }
                }
                
                var temp: [ChickenUIResponseModel?] = []
                
                for await newChicken in group {
                    temp.append(newChicken)
                }
                
                return temp.compactMap { $0 }
            }
            
            await MainActor.run {
                self.favoritesChicken = favorites
                self.scannedChickens = resultWithImages
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
