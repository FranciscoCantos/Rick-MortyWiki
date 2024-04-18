import Foundation

protocol GetCharactersListUseCaseProtocol {
    func execute() async -> Result<[CharacterInfo], DomainError>
}

class GetCharactersListUseCase: GetCharactersListUseCaseProtocol {
    private let repository: CharactersRepositoryProtocol
    
    init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<[CharacterInfo], DomainError> {
        return await repository.getAllCharactersList()
    }
}
