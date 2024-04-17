import Foundation

struct CharacterDetailViewItem {
    let id: Int
    let name: String
    let imageUrl: URL?
    let status: String
    let species: String
    let url: URL?
    let type: String
    let gender: CharacterGender
    let origin: String
    let location: String
    let episodesList: [String]
    let createdDate: Date?
    
    init(model: CharacterInfo) {
        self.id = model.id
        self.name = model.name.capitalized
        self.imageUrl = model.imageURL
        self.status = model.status.rawValue.capitalized
        self.species = model.species.capitalized
        self.url = model.url
        self.type = model.type
        self.gender = model.gender
        self.origin = model.origin
        self.location = model.location
        self.episodesList = model.episodesList
        self.createdDate = model.createdDate
    }
}
