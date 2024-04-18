import Foundation
@testable import Rick_MortyWiki

class CharacterDetailRepositoryStub : CharacterDetailRepositoryProtocol {
    private let result: Result<CharacterInfo,DomainError>
    
    init(result: Result<CharacterInfo, DomainError>) {
        self.result = result
    }
    
    func getCharacterDetail(forId: Int) async -> Result<Rick_MortyWiki.CharacterInfo, Rick_MortyWiki.DomainError> {
        return result
    }
}
