import Foundation
import RickMortySwiftApi

protocol HTTPClientProtocol {
    func requestAllCharacters() async -> Result<[RMCharacterModel], HTTPClientError>
}

class HTTPClient: HTTPClientProtocol {
    private let apiClient: RMClient
    
    init(apiClient: RMClient) {
        self.apiClient = apiClient
    }
    
    func requestAllCharacters() async -> Result<[RMCharacterModel], HTTPClientError> {
        do {
            let result = try await apiClient.character().getAllCharacters()
            return .success(result)
        } catch {
            return .failure(.generic)
        }
    }
}
