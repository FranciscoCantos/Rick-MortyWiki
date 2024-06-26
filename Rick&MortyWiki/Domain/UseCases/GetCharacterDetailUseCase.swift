import Foundation

protocol GetCharacterDetailUseCaseProtocol {
    func execute(forId: Int) async -> Result<CharacterInfo, DomainError>
}

class GetCharacterDetailUseCase: GetCharacterDetailUseCaseProtocol {
    private let repository: CharacterDetailRepositoryProtocol
    
    init(repository: CharacterDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(forId id: Int) async -> Result<CharacterInfo, DomainError> {
        return await repository.getCharacterDetail(forId: id)
    }
}
