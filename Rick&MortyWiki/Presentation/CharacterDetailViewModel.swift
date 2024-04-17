import Foundation

class CharactersDetailViewModel: ObservableObject {
    private let getCharacterDetailUseCase: GetCharacterDetailUseCaseProtocol
    private let errorMapper: PresentationErrorMapper
    private let charaterId: Int
    
    @Published var characterItem: CharacterDetailViewItem?
    @Published var showLoading: Bool = false
    @Published var errorMessage: String?

    init(id: Int, getCharacterDetailUseCase: GetCharacterDetailUseCaseProtocol, errorMapper: PresentationErrorMapper) {
        self.charaterId = id
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        showLoading = true
        Task {
            let result = await self.getCharacterDetailUseCase.execute(forId: charaterId)
            
            guard case .success(let character) = result else {
                handleError(error: result.failureValue as? DomainError)
                return
            }
                        
            Task { @MainActor in
                self.showLoading = false
                self.errorMessage = nil
                self.characterItem = CharacterDetailViewItem(model: character)
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
