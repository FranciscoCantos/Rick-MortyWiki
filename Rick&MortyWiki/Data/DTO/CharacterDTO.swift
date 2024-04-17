import Foundation

struct CharacterDTO: Identifiable {
    let id: Int
    let name: String
    let url: String
    let image: String
    let status: CharacterStatus
    let species: String
}
