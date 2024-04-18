import Foundation
import RickMortySwiftApi

class RMAPIManager {
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
    
    func requestCharacter(forId id: Int) async -> Result<RMCharacterModel, HTTPClientError> {
        do {
            let result = try await apiClient.character().getCharacterByID(id: id)
            return .success(result)
        } catch {
            return .failure(.generic)
        }
    }
}
