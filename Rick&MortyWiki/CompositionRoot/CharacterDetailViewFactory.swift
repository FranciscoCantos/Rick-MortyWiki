import Foundation
import RickMortySwiftApi

class CharacterDetailViewFactory: CreateCharacterDetailViewProtocol {
    func createView(forId id: Int) -> CharacterDetailView {
        return CharacterDetailView(viewModel: CharactersDetailViewModel(id: id,
                                                                        getCharacterDetailUseCase: createUseCase(),
                                                                        errorMapper: PresentationErrorMapper()))
    }
    
    private func createUseCase() -> GetCharacterDetailUseCaseProtocol {
        return GetCharacterDetailUseCase(repository: createRepository())
    }
    
    private func createRepository() -> CharacterDetailRepositoryProtocol {
        return CharacterDetailRepository(apiDataSource: createAPIDataSource(),
                                         cacheDataSource: createCacheDataSource())
    }
    
    private func createCacheDataSource() -> CharactersCacheDataSourceProtocol {
        return CharactersCacheDataSource(container: SwiftDataContainer.shared())
    }
        
    private func createAPIDataSource() -> APICharactersDataSourceProtocol {
        return APICharactersDataSource(restClient: createRestClient(),
                                       domainMapper: CharacterDomainMapper())
    }
    
    private func createRestClient() -> HTTPClient {
        return HTTPClient(apiClient: RMClient())
    }
}
