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
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(3.0, anchor: .center)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .background(Color.rmGreyDark)
                    .tint(.white)
            } else {
                if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Button(action: viewModel.onAppear) {
                          Label(errorMessage, systemImage: "person.crop.circle.badge.exclamationmark.fill")
                            .padding(12)
                            .foregroundColor(.white)
                            .background(.red,
                               in: RoundedRectangle(cornerRadius: 12))
                        }
                    }
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
