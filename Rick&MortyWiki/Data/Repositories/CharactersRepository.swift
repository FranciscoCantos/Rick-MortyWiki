import Foundation

protocol CharactersRepositoryProtocol {
    func getAllCharactersList() async -> Result<[CharacterBasicInfo], DomainError>
}

class CharactersRepository: CharactersRepositoryProtocol {
    private let apiDataSource: APICharactersDataSourceProtocol
    
    init(apiDataSource: APICharactersDataSourceProtocol) {
        self.apiDataSource = apiDataSource
    }
    
    func getAllCharactersList() async -> Result<[CharacterBasicInfo], DomainError> {
        let result = await apiDataSource.getAllCharacters()
        
        guard case .success(let charactersList) = result else {
            return .failure(.generic)
        }
        
        if charactersList.isEmpty {
            return .failure(.emptyResponse)
        }
        
        let charactersListDomain = charactersList.map { CharacterBasicInfo(id: $0.id, name: $0.name, image: $0.image, status: $0.status, species: $0.species) }
        return .success(charactersListDomain)
    }
}
