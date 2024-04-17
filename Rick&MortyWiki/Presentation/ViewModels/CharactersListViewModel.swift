import Foundation

class CharactersListViewModel: ObservableObject {
    private let getCharactersListUseCase: GetCharactersListUseCaseProtocol
    private let searchCharacterUseCase: SearchCharacterUseCaseProtocol
    private let errorMapper: PresentationErrorMapper
    
    @Published var charactersItems: [CharacterViewItem] = []
    @Published var showLoading: Bool = false
    @Published var errorMessage: String?

    init(getCharactersListUseCase: GetCharactersListUseCaseProtocol, searchCharacterUseCase: SearchCharacterUseCaseProtocol, errorMapper: PresentationErrorMapper) {
        self.getCharactersListUseCase = getCharactersListUseCase
        self.searchCharacterUseCase = searchCharacterUseCase
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        showLoading = true
        Task {
            let result = await self.getCharactersListUseCase.execute()
            
            guard case .success(let characters) = result else {
                handleError(error: result.failureValue as? DomainError)
                return
            }
            
            let charactersItems = characters.map({ CharacterViewItem(model: $0) })
            
            Task { @MainActor in
                self.showLoading = false
                self.errorMessage = nil
                self.charactersItems = charactersItems
            }
        }
    }
    
    func search(cryptoName: String) {
        Task {
            let result = await searchCharacterUseCase.execute(characterName: cryptoName)
            
            guard case .success(let characters) = result else {
                handleError(error: result.failureValue as? DomainError)
                return
            }
            
            let charactersItems = characters.map({ CharacterViewItem(model: $0) })
            
            Task { @MainActor in
                self.showLoading = false
                self.errorMessage = nil
                self.charactersItems = charactersItems
            }
        }
    }
    
    private func handleError(error: DomainError?) {
        Task { @MainActor in
            showLoading = false
            errorMessage = errorMapper.map(error: error)
        }
    }
}
