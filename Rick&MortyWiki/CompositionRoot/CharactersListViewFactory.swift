import Foundation
import RickMortySwiftApi

class CharactersListViewFactory {
    func createView() -> CharactersListView {
        return CharactersListView(viewModel: CharactersListViewModel(getCharactersListUseCase: createGetUseCase(), 
                                                                     getMoreCharactersListUseCase: createGetMoreUseCase(),
                                                                     searchCharacterUseCase: createSearchUseCase(),
                                                                     errorMapper: createErrorMapper()),
                                  createCharacterDetailView: createDetailView())
    }
    
    private func createGetUseCase() -> GetCharactersListUseCaseProtocol {
        return GetCharactersListUseCase(repository: createRepository())
    }
    
    private func createGetMoreUseCase() -> GetMoreCharactersListUseCaseProtocol {
        return GetMoreCharactersListUseCase(repository: createRepository())
    }
    
    private func createSearchUseCase() -> SearchCharacterUseCaseProtocol {
        return SearchCharacterUseCase(repository: createRepository())
    }
    
    private func createErrorMapper() -> PresentationErrorMapper {
        return PresentationErrorMapper()
    }
    
    private func createRepository() -> CharactersRepositoryProtocol {
        return CharactersRepository(apiDataSource: createHTTPAPIDataSource(),
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
    
    private func createHTTPClient() -> HTTPClientProtocol {
        return HTTPClient(requestBuilder: HTTPRequestBuilder(),
                          errorsResolver: HTTPErrorsResolver())
    }
    
    private func createRestClient() -> RMAPIManager {
        return RMAPIManager(apiClient: RMClient())
    }
    
    private func createDetailView() -> CreateCharacterDetailViewProtocol {
        return CharacterDetailViewFactory()
    }
}
