import Foundation

struct CharacterDTO: Identifiable {
    let id: Int
    let name: String
    let url: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: String
    let location: String
    let imageURL: String
    let episodes: [String]
    let created: String
}
