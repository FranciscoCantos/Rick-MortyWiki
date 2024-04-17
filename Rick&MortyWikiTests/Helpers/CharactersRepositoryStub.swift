import Foundation
@testable import Rick_MortyWiki

class CharactersRepositoryStub : CharactersRepositoryProtocol {
    private let result: Result<[CharacterInfo], DomainError>
    
    init(result: Result<[CharacterInfo], DomainError>) {
        self.result = result
    }
    
    func getAllCharactersList() async -> Result<[CharacterInfo], DomainError> {
        return result
    }
    
    func searchCharacter(byName: String) async -> Result<[CharacterInfo], DomainError> {
        return result
    }
}
