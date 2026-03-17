import Foundation

struct ChickenBreedResponse: Identifiable, Codable {

    let breed: String
    let description: String
    let lifeExpectancy: Int
    let avgPrice: Int

    var id: UUID = UUID()

    enum CodingKeys: String, CodingKey {
        case breed
        case description
        case lifeExpectancy
        case avgPrice
    }
}
