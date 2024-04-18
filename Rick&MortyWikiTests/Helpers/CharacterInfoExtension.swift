import Foundation
@testable import Rick_MortyWiki

extension CharacterInfo {
    static func getMocks() -> [CharacterInfo] {
        return [
            CharacterInfo(id: 000,
                          name: "000",
                          imageURL: nil,
                          status: .dead,
                          species: "000",
                          url: nil,
                          type: "000",
                          gender: .unknown,
                          origin: "000",
                          location: "000",
                          episodesList: ["000"],
                          createdDate: nil),
            CharacterInfo(id: 001,
                          name: "001",
                          imageURL: nil,
                          status: .dead,
                          species: "001",
                          url: nil,
                          type: "001",
                          gender: .unknown,
                          origin: "001",
                          location: "001",
                          episodesList: ["001"],
                          createdDate: nil),
            CharacterInfo(id: 002,
                          name: "002",
                          imageURL: nil,
                          status: .dead,
                          species: "002",
                          url: nil,
                          type: "002",
                          gender: .unknown,
                          origin: "002",
                          location: "002",
                          episodesList: ["002"],
                          createdDate: nil),
        ]
    }
}
