import Foundation

protocol CharacterDetailRepositoryProtocol {
    func getCharacterDetail(forId: Int) async -> Result<CharacterInfo, DomainError>
}

class CharacterDetailRepository: CharacterDetailRepositoryProtocol {
    private let apiDataSource: APICharactersDataSourceProtocol
    private let cacheDataSource: CharactersCacheDataSourceProtocol
    
    init(apiDataSource: APICharactersDataSourceProtocol, cacheDataSource: CharactersCacheDataSourceProtocol) {
        self.apiDataSource = apiDataSource
        self.cacheDataSource = cacheDataSource
    }
        
    func getCharacterDetail(forId id: Int) async -> Result<CharacterInfo, DomainError> {
        let cacheCharacters = await cacheDataSource.getCharacters()
        if !cacheCharacters.isEmpty {
            if let character = cacheCharacters.first(where: { $0.id == id }) {
                return .success(character)
            }
        }
        
        let result = await apiDataSource.getCharacter(forId: id)
        
        guard case .success(let characterDto) = result else {
            return .failure(.idNotFound)
        }
        
        if characterDto.id != id {
            return .failure(.idNotFound)
        }
        
        let character = CharacterInfo(dto: characterDto)
        
        return .success(character)
    }
}
