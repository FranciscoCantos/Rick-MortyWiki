import Foundation
import SwiftData

class SwiftDataContainer: CacheContainerProtocol {
    private static let sharedInstance = SwiftDataContainer()
    
    private let container: ModelContainer
    private let context: ModelContext
    
    private init() {
        let schema = Schema([CharacterInfoData.self])
        container = try! ModelContainer(for: schema, configurations: [])
        context = ModelContext(container)
    }
    
    static func shared() -> SwiftDataContainer {
        return sharedInstance
    }
    
    func fetchCharacters() -> [CharacterInfo] {
        let descriptor = FetchDescriptor<CharacterInfoData>()
        guard let characters = try? context.fetch(descriptor) else {
            return []
        }
        
        let result = characters.map { CharacterInfo(id: $0.id,
                                                    name: $0.name,
                                                    imageURL: $0.imageURL,
                                                    status: $0.status,
                                                    species: $0.species,
                                                    url: $0.url,
                                                    type: $0.type,
                                                    gender: $0.gender,
                                                    origin: $0.origin,
                                                    location: $0.location,
                                                    episodesList: $0.episodesList,
                                                    createdDate: $0.createdDate) }
        return result
    }
    
    func insertCharaters(_ characters: [CharacterInfo]) async {
        let savedCharactersIds = self.fetchCharacters().map { $0.id }
        
        characters.forEach { character in
            if !savedCharactersIds.contains(savedCharactersIds) {
                context.insert(CharacterInfoData(id: character.id,
                                                 name: character.name,
                                                 imageURL: character.imageURL,
                                                 status: character.status,
                                                 species: character.species,
                                                 url: character.url,
                                                 type: character.type,
                                                 gender: character.gender,
                                                 origin: character.origin,
                                                 location: character.location,
                                                 episodesList: character.episodesList,
                                                 createdDate: character.createdDate))
            }
        }
        
        try? context.save()
    }
}
