import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject private var viewModel: CharactersDetailViewModel
    
    init(viewModel: CharactersDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.rmGreyDark.edgesIgnoringSafeArea(.all)
            ScrollView {
                if viewModel.showLoading {
                    LoadingView()
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(text: errorMessage) {
                        viewModel.onAppear()
                    }
                } else {
                    if let characterItem = viewModel.characterItem {
                        AsyncImage(url: characterItem.imageUrl,
                                   transaction: .init(animation: .bouncy(duration: 1))) { phase in
                            if let image = phase.image {
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            } else if phase.error != nil {
                                Image("PlaceholderImage").resizable()
                                    .aspectRatio(contentMode: .fit)
                            } else {
                                ProgressView().progressViewStyle(.circular)
                            }
                        }.clipShape(RoundedRectangle(cornerRadius: 16))
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Status:")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundStyle(.white)
                                Text("Specie:")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundStyle(.white)
                                Text("Gender:")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundStyle(.white)
                                Text("Origin:")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundStyle(.white)
                                Text("Location:")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundStyle(.white)
                                Text("Creation Date:")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundStyle(.white)
                                Text("Appearances:")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(characterItem.status)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                Text(characterItem.species)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                Text(characterItem.gender.rawValue.capitalized)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                Text(characterItem.origin)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                Text(characterItem.location)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                Text(characterItem.createdDate?.formatted() ?? "Not Available")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                Text("\(characterItem.episodesList.count)")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                        if let linkUrl = characterItem.url {
                            Link(destination: linkUrl) {
                                Image(systemName: "link.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                }
            }.onAppear {
                viewModel.onAppear()
            }.navigationTitle(viewModel.characterItem?.name ?? "")
                .background(viewModel.showLoading || viewModel.errorMessage != nil ? .clear : .rmGreyLight)
                .scrollContentBackground(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .contentMargins(0, for: .automatic)
        }
    }
}
