import Foundation

protocol CharactersRepositoryProtocol {
    func getAllCharactersList() async -> Result<[CharacterInfo], DomainError>
    func getCharacterDetail(forId: Int) async -> Result<CharacterInfo, DomainError>
}

class CharactersRepository: CharactersRepositoryProtocol {
    private let apiDataSource: APICharactersDataSourceProtocol
    private let cacheDataSource: CharactersCacheDataSourceProtocol
    
    init(apiDataSource: APICharactersDataSourceProtocol, cacheDataSource: CharactersCacheDataSourceProtocol) {
        self.apiDataSource = apiDataSource
        self.cacheDataSource = cacheDataSource
    }
    
    func getAllCharactersList() async -> Result<[CharacterInfo], DomainError> {
        let cacheCaracters = await cacheDataSource.getCharacters()
        if !cacheCaracters.isEmpty {
            return .success(cacheCaracters)
        }
        
        let result = await apiDataSource.getAllCharacters()
        
        guard case .success(let charactersList) = result else {
            return .failure(.generic)
        }
        
        if charactersList.isEmpty {
            return .failure(.emptyResponse)
        }
                
        let charactersListDomain = charactersList.map { CharacterInfo(dto: $0) }
        
        await cacheDataSource.saveCharacters(charactersListDomain)

        return .success(charactersListDomain)
    }
    
    func getCharacterDetail(forId id: Int) async -> Result<CharacterInfo, DomainError> {
        let cacheCaracters = await cacheDataSource.getCharacters()
        if !cacheCaracters.isEmpty {
            if let character = cacheCaracters.first(where: { $0.id == id }) {
                return .success(character)
            }
        }
        
        let result = await apiDataSource.getCharacter(forId: id)
        
        guard case .success(let characterDto) = result else {
            return .failure(.idNotFound)
        }
        
        let character = CharacterInfo(dto: characterDto)
        
        return .success(character)
    }
}
