import Foundation
import SwiftData

@Model
class CharacterInfoData {
    let id: Int
    let name: String
    let imageURL: URL?
    let status: CharacterStatus
    let species: String
    let url: URL?
    let type: String
    let gender: CharacterGender
    let origin: String
    let location: String
    let episodesList: [String]
    let createdDate: Date?
    
    init(id: Int, name: String, imageURL: URL?, status: CharacterStatus, species: String, url: URL?, type: String, gender: CharacterGender, origin: String, location: String, episodesList: [String], createdDate: Date?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.status = status
        self.species = species
        self.url = url
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.episodesList = episodesList
        self.createdDate = createdDate
    }
}
