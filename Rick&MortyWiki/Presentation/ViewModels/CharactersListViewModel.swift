import Foundation

class CharactersListViewModel: ObservableObject {
    private let getCharactersListUseCase: GetCharactersListUseCaseProtocol
    private let getMoreCharactersListUseCase: GetMoreCharactersListUseCaseProtocol
    private let searchCharacterUseCase: SearchCharacterUseCaseProtocol
    private let errorMapper: PresentationErrorMapper
    
    @Published var charactersItems: [CharacterViewItem] = []
    @Published var showLoading: Bool = false
    @Published private var isSearching: Bool = false
    @Published var errorMessage: String?
    
    init(getCharactersListUseCase: GetCharactersListUseCaseProtocol, getMoreCharactersListUseCase: GetMoreCharactersListUseCaseProtocol, searchCharacterUseCase: SearchCharacterUseCaseProtocol, errorMapper: PresentationErrorMapper) {
        self.getCharactersListUseCase = getCharactersListUseCase
        self.searchCharacterUseCase = searchCharacterUseCase
        self.getMoreCharactersListUseCase = getMoreCharactersListUseCase
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        requestCharacters()
    }
    
    func fecthMoreCharacters() {
        if !isSearching {
            requestMoreCharacters()
        }
    }
    
    func search(characterName: String) {
        isSearching = !characterName.isEmpty
        Task {
            let result = await searchCharacterUseCase.execute(characterName: characterName)
            
            guard case .success(let characters) = result else {
                handleError(error: result.failureValue as? DomainError)
                return
            }
            
            let charactersItems = characters.map({ CharacterViewItem(model: $0) })
            
            Task { @MainActor in
                self.showLoading = false
                self.errorMessage = nil
                self.charactersItems = charactersItems.filter({ $0.name.contains(characterName) })
            }
        }
    }
    
    func isTheLastCharacter(_ id: Int) -> Bool {
        charactersItems.last?.id == id
    }
    
    private func handleError(error: DomainError?) {
        Task { @MainActor in
            showLoading = false
            errorMessage = errorMapper.map(error: error)
        }
    }
    
    private func requestCharacters() {
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
                print("-->> Insert \(charactersItems.count) > \(self.charactersItems.count)")
                self.charactersItems = charactersItems
            }
        }
    }
    
    private func requestMoreCharacters() {
        showLoading = true
        Task {
            let result = await self.getMoreCharactersListUseCase.execute()
            
            guard case .success(let characters) = result else {
                handleError(error: result.failureValue as? DomainError)
                return
            }
            
            let charactersItems = characters.map({ CharacterViewItem(model: $0) })
            
            Task { @MainActor in
                self.showLoading = false
                self.errorMessage = nil
                print("-->> Add \(charactersItems.count) > \(self.charactersItems.count)")
                self.charactersItems.append(contentsOf: charactersItems)
            }
        }
    }
}
