import Foundation

struct CharactersResponseDTO: Codable {
    let info: PaginationInfo
    let results: [CharacterDTO]
}
