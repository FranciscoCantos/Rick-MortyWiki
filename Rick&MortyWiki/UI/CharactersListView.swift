import SwiftUI

struct CharactersListView: View {
    private let createCharacterDetailView: CreateCharacterDetailViewProtocol
    
    @ObservedObject private var viewModel: CharactersListViewModel
    @State private var searchText: String = ""
    
    init(viewModel: CharactersListViewModel, createCharacterDetailView: CreateCharacterDetailViewProtocol) {
        self.viewModel = viewModel
        self.createCharacterDetailView = createCharacterDetailView
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.showLoading {
               LoadingView()
            } else {
                if let errorMessage = viewModel.errorMessage {
                    ErrorView(text: errorMessage, action: viewModel.onAppear)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100)),
                                            GridItem(.adaptive(minimum: 100)),
                                            GridItem(.adaptive(minimum: 100))],
                                  content: {
                            if viewModel.charactersItems.isEmpty {
                                VStack(alignment: .center) {
                                    Text("Sorry, no results were found. Please repeat your search.")
                                        .font(.title)
                                }
                            } else {
                                ForEach(viewModel.charactersItems, id: \.id) { character in
                                    NavigationLink {
                                        createCharacterDetailView.createView(forId: character.id)
                                    } label: {
                                        CharacterCardView(item: character)
                                            .task {
                                                if viewModel.isTheLastCharacter(character.id) {
                                                    viewModel.fecthMoreCharacters()
                                                }
                                            }
                                    }
                                }
                            }
                        }).searchable(text: $searchText,
                                      placement: .navigationBarDrawer(displayMode:.always))
                        .preferredColorScheme(.dark)
                        .onChange(of: searchText) { oldValue, newValue in
                            viewModel.search(cryptoName: newValue)
                        }
                        .padding(20)
                    }.background(Color.rmGreyDark)
                }
            }
        }.onAppear {
            viewModel.onAppear()
        }.tint(.white)
    }
}
