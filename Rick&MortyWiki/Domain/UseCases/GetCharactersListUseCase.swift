import Foundation

protocol GetCharactersListUseCaseProtocol {
    func execute() async -> Result<[CharacterBasicInfo], DomainError>
}

class GetCharactersListUseCase: GetCharactersListUseCaseProtocol {
    private let repository: CharactersRepositoryProtocol
    
    init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<[CharacterBasicInfo], DomainError> {
        return await repository.getAllCharactersList()
    }
}
