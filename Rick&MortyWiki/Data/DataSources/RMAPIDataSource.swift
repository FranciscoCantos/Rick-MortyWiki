import Foundation

class RMAPIDataSource: APICharactersDataSourceProtocol {
    private let restClient: RMAPIManager
    private let domainMapper: CharacterDomainMapper
    
    init(restClient: RMAPIManager, domainMapper: CharacterDomainMapper) {
        self.restClient = restClient
        self.domainMapper = domainMapper
    }
    
    func getAllCharacters() async -> Result<[CharacterDTO], HTTPClientError> {
        let result = await restClient.requestAllCharacters()
        
        guard case .success(let charactersList) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        let charactersDomainList = domainMapper.map(apiModels: charactersList)
        return .success(charactersDomainList)
    }
    
    func getCharacter(forId id: Int) async -> Result<CharacterDTO, HTTPClientError> {
        let result = await restClient.requestCharacter(forId: id)
        
        guard case .success(let character) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
                
        let charactersDomain = CharacterDTO(id: character.id,
                                            name: character.name,
                                            url: character.url,
                                            status: character.status,
                                            species: character.species,
                                            type: character.type,
                                            gender: character.gender,
                                            origin: character.origin.name,
                                            location: character.location.name,
                                            imageURL: character.image,
                                            episodes: character.episode,
                                            created: character.created)
        return .success(charactersDomain)
    }
    
    func searchCharacter(forName name: String) async -> Result<[CharacterDTO], HTTPClientError> {
        let result = await restClient.requestAllCharacters()
        
        guard case .success(let charactersList) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        let filteredCharacters = domainMapper.map(apiModels: charactersList).filter { $0.name.lowercased().contains(name.lowercased())}
        return .success(filteredCharacters)
    }
        
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else { return .generic }
        return error
    }
}
