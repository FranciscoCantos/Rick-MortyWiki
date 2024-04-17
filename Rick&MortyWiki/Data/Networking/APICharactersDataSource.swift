import Foundation

protocol APICharactersDataSourceProtocol {
    func getAllCharacters() async -> Result<[CharacterDTO], HTTPClientError>
}

class APICharactersDataSource: APICharactersDataSourceProtocol {
    private let restClient: HTTPClient
    private let domainMapper: CharacterDomainMapper
    
    init(restClient: HTTPClient, domainMapper: CharacterDomainMapper) {
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
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else { return .generic }
        return error
    }
}
