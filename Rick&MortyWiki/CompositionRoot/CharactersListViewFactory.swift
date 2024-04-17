import Foundation
import RickMortySwiftApi

class CharactersListViewFactory {
    func createView() -> CharactersListView {
        return CharactersListView(viewModel: CharactersListViewModel(getCharactersListUseCase: createUseCase(),
                                                                     errorMapper: createErrorMapper()),
                                  createCharacterDetailView: createDetailView())
    }
    
    private func createUseCase() -> GetCharactersListUseCaseProtocol {
        return GetCharactersListUseCase(repository: createRepository())
    }
    
    private func createErrorMapper() -> PresentationErrorMapper {
        return PresentationErrorMapper()
    }
    
    private func createRepository() -> CharactersRepositoryProtocol {
        return CharactersRepository(apiDataSource: createAPIDataSource(),
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
    
    private func createDetailView() -> CreateCharacterDetailViewProtocol {
        return CharacterDetailViewFactory()
    }
}