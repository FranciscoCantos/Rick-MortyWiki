import Foundation

struct CharacterViewItem {
    let id: Int
    let name: String
    let image: URL?
    let status: String
    let bulletStatus: String
    let species: String
    let description: String
    
    init(model: CharacterBasicInfo) {
        self.id = model.id
        self.name = model.name.capitalized
        self.image = URL(string: model.image)
        self.status = model.status.rawValue.capitalized
        self.species = model.species.capitalized
        
        switch model.status {
        case .alive:
            self.bulletStatus = "🟢"
        case .dead:
            self.bulletStatus = "🔴"
        case .unknown:
            self.bulletStatus = "⚫️"
        }
        
        self.description = bulletStatus + " - " + status
    }
}
