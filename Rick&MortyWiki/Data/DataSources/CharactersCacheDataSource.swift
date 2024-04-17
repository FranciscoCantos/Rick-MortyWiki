import Foundation

protocol CharactersCacheDataSourceProtocol {
    func getCharacters() async -> [CharacterInfo]
    func saveCharacters(_ characters: [CharacterInfo]) async
}

class CharactersCacheDataSource: CharactersCacheDataSourceProtocol {
    private let container: CacheContainerProtocol
    
    init(container: CacheContainerProtocol) {
        self.container = container
    }
    
    func getCharacters() async -> [CharacterInfo] {
        return container.fetchCharacters()
    }
    
    func saveCharacters(_ characters: [CharacterInfo]) async {
        await container.insertCharaters(characters)
    }
}
