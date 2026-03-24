import UIKit
import Combine

final class CameraResultViewModel: ObservableObject {
    
    private let storage = LocalStorageManager.instance
    private let imageStorage = ImageDiskRepository.instance
    
    @Published var shouldClose = false
    
    func save(_ model: ChickenUIResponseModel) {
        guard let response = model.response else { return }
        
        Task {
            var chickens = await self.storage.fetch([ChickenResponseModelDTO].self, for: .newChicken) ?? []
            
            let newChicken = ChickenResponseModelDTO(id: model.id, response: response, isFavorite: model.isFavorite)
            
            await self.imageStorage.store(model.image, id: model.id)
            
            if let index = chickens.firstIndex(where: { $0.id == model.id }) {
                chickens[index] = newChicken
            } else {
                chickens.append(newChicken)
            }
            
            await self.storage.store(chickens, key: .newChicken)
            
            await MainActor.run {
                self.shouldClose = true 
            }
        }
    }
}
