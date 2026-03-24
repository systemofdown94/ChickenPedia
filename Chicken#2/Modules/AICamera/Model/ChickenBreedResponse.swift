import Foundation

struct ChickenBreedResponse: Identifiable, Codable, Equatable, Hashable {

    let breed: String
    let description: String
    let lifeExpectancy: Int
    let avgPrice: Int
    let layingRate: Int
    let rarity: String

    var id: UUID = UUID()

    enum CodingKeys: String, CodingKey {
        case breed
        case description
        case lifeExpectancy
        case avgPrice
        case layingRate
        case rarity
    }
}
