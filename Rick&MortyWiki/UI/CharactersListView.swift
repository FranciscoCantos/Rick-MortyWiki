import SwiftUI

struct CharactersListView: View {
    private let createCharacterDetailView: CreateCharacterDetailViewProtocol
    @ObservedObject private var viewModel: CharactersListViewModel
    
    init(viewModel: CharactersListViewModel, createCharacterDetailView: CreateCharacterDetailViewProtocol) {
        self.viewModel = viewModel
        self.createCharacterDetailView = createCharacterDetailView
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(3.0, anchor: .center)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .background(Color.rmGreyDark)
                    .tint(.white)
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Button(errorMessage, role: .destructive) {
                        viewModel.onAppear()
                    }
                    .buttonStyle(.borderedProminent)
                    
                } else {
                    NavigationStack {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible(minimum: 100)),
                                                GridItem(.flexible(minimum: 100))],
                                      content: {
                                ForEach(viewModel.charactersItems, id: \.id) { character in
                                    NavigationLink {
                                        createCharacterDetailView.createView(forId: character.id)
                                    } label: {
                                        CharacterCardView(item: character)
                                    }
                                }
                            })
                            .padding(20)
                        }.background(Color.rmGreyDark)
                    }.tint(.white)
                }
            }
        }.onAppear {
            viewModel.onAppear()
        }
    }
}
