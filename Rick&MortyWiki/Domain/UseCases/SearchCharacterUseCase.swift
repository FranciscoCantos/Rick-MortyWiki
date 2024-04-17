
import Foundation

protocol SearchCharacterUseCaseProtocol {
    func execute(characterName: String) async -> Result<[CharacterInfo], DomainError>
}

class SearchCharacterUseCase: SearchCharacterUseCaseProtocol {
    private let repository: CharactersRepositoryProtocol
    
    init(repository: CharactersRepositoryProtocol) {
       self.repository = repository
   }
    
    func execute(characterName name: String) async -> Result<[CharacterInfo], DomainError> {
        return await repository.searchCharacter(byName: name)
    }
}
