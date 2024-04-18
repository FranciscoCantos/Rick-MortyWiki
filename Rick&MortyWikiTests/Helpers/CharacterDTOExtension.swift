import Foundation
@testable import Rick_MortyWiki

extension CharacterDTO {
    static func getMocks() -> [CharacterDTO] {
        return [
            CharacterDTO(id: 000,
                         name: "000",
                         url: "000",
                         status: "000",
                         species: "000",
                         type: "000",
                         gender: "000",
                         origin: "000",
                         location: "000",
                         imageURL: "000",
                         episodes: ["000"],
                         created: "000"),
            CharacterDTO(id: 001,
                         name: "001",
                         url: "001",
                         status: "001",
                         species: "001",
                         type: "001",
                         gender: "001",
                         origin: "001",
                         location: "001",
                         imageURL: "001",
                         episodes: ["001"],
                         created: "001"),
            CharacterDTO(id: 002,
                         name: "002",
                         url: "002",
                         status: "002",
                         species: "002",
                         type: "002",
                         gender: "002",
                         origin: "002",
                         location: "002",
                         imageURL: "002",
                         episodes: ["002"],
                         created: "002")
        ]
    }
}
