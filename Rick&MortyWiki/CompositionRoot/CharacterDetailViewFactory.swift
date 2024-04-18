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
        return CharacterDetailRepository(apiDataSource: createHTTPAPIDataSource(),
                                         cacheDataSource: createCacheDataSource())
    }
    
    private func createCacheDataSource() -> CharactersCacheDataSourceProtocol {
        return CharactersCacheDataSource(container: SwiftDataContainer.shared())
    }
    
    private func createHTTPAPIDataSource() -> APICharactersDataSourceProtocol {
        return RestAPIDataSource(httpClient: createHTTPClient())
    }

    private func createRMAPIDataSource() -> APICharactersDataSourceProtocol {
        return RMAPIDataSource(restClient: createRestClient(),
                                       domainMapper: CharacterDomainMapper())
    }
    
    private func createRestClient() -> RMAPIManager {
        return RMAPIManager(apiClient: RMClient())
    }
    
    
    private func createHTTPClient() -> HTTPClientProtocol {
        return HTTPClient(requestBuilder: HTTPRequestBuilder(),
                          errorsResolver: HTTPErrorsResolver())
    }
            
    private func createRMApiManager() -> RMAPIManager {
        return RMAPIManager(apiClient: RMClient())
    }
}
