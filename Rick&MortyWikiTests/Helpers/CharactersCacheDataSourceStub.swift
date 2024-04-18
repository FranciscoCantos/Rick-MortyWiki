import Foundation
@testable import Rick_MortyWiki

class CharactersCacheDataSourceStub: CharactersCacheDataSourceProtocol {
    private var result: [CharacterInfo]
                         
    init(result: [CharacterInfo]) {
        self.result = result
    }
    
    func getCharacters() async -> [CharacterInfo] {
        return result
    }
    
    func saveCharacters(_ characters: [CharacterInfo]) async {
        result = characters
    }
}
