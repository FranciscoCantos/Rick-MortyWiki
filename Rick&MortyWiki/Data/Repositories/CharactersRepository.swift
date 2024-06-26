import Foundation

protocol CharactersRepositoryProtocol {
    func getAllCharactersList() async -> Result<[CharacterInfo], DomainError>
    func getMoreCharactersList() async -> Result<[CharacterInfo], DomainError>
    func searchCharacter(byName: String) async -> Result<[CharacterInfo], DomainError>
}

class CharactersRepository: CharactersRepositoryProtocol {
    private let apiDataSource: APICharactersDataSourceProtocol
    private let cacheDataSource: CharactersCacheDataSourceProtocol
    
    init(apiDataSource: APICharactersDataSourceProtocol, cacheDataSource: CharactersCacheDataSourceProtocol) {
        self.apiDataSource = apiDataSource
        self.cacheDataSource = cacheDataSource
    }
    
    func getAllCharactersList() async -> Result<[CharacterInfo], DomainError> {
        let cacheCharacters = await cacheDataSource.getCharacters()
        if !cacheCharacters.isEmpty {
            return .success(cacheCharacters)
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
    
    func getMoreCharactersList() async -> Result<[CharacterInfo], DomainError> {
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
        
    func searchCharacter(byName name: String) async -> Result<[CharacterInfo], DomainError> {        
        let result = await apiDataSource.searchCharacter(forName: name)
        
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
}
