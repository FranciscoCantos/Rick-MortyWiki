import Foundation

protocol GetMoreCharactersListUseCaseProtocol {
    func execute() async -> Result<[CharacterInfo], DomainError>
}

class GetMoreCharactersListUseCase: GetMoreCharactersListUseCaseProtocol {
    private let repository: CharactersRepositoryProtocol
    
    init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<[CharacterInfo], DomainError> {
        return await repository.getMoreCharactersList()
    }
}
