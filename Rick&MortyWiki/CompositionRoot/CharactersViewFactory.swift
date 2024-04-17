import Foundation
import RickMortySwiftApi

class CharactersViewFactory {
    func createView() -> CharactersListView {
        return CharactersListView(viewModel: CharactersListViewModel(getCharactersListUseCase: createUseCase(),
                                                                 errorMapper: createErrorMapper()))
    }
    
    private func createUseCase() -> GetCharactersListUseCaseProtocol {
        return GetCharactersListUseCase(repository: createRepository())
    }
    
    private func createErrorMapper() -> PresentationErrorMapper {
        return PresentationErrorMapper()
    }
    
    private func createRepository() -> CharactersRepositoryProtocol {
        return CharactersRepository(apiDataSource: createDataSource())
    }
    
    private func createDataSource() -> APICharactersDataSourceProtocol {
        return APICharactersDataSource(restClient: createRestClient(),
                                       domainMapper: CharacterDomainMapper())
    }
    
    private func createRestClient() -> HTTPClient {
        return HTTPClient(apiClient: RMClient())
    }
}
