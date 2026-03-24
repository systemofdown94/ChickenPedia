import UIKit

struct ChickenUIResponseModel: Identifiable, Hashable, Equatable {
    let id: UUID
    let image: UIImage
    let response: ChickenBreedResponse?
    var isFavorite: Bool 
}

struct ChickenResponseModelDTO: Codable {
    let id: UUID
    let response: ChickenBreedResponse
    var isFavorite: Bool 
}
