import SwiftUI

struct CharactersListView: View {
    @ObservedObject private var viewModel: CharactersListViewModel
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(3.0, anchor: .center)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .shadow(radius: 10)
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
                                        //kurro createCryptoDetailView.createView(cryptoCurrency: crypto)
                                    } label: {
                                        CharacterItemView(item: character)
                                    }
                                }
                            })
                            .padding(20)
                        }.background(Color.rmGreyDark)
                    }
                }
            }
        }.onAppear {
            viewModel.onAppear()
        }.refreshable {
            viewModel.onAppear()
        }
    }
}
