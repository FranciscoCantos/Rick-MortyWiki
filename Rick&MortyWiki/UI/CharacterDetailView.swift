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
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(3.0, anchor: .center)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .tint(.white)
                } else if let errorMessage = viewModel.errorMessage {
                    Button(errorMessage, role: .destructive) {
                        viewModel.onAppear()
                    }
                    .buttonStyle(.borderedProminent)
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
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                        //                    VStack(alignment: .leading) {
                        //                        Text("Episodes:")
                        //                            .font(.system(size: 16))
                        //                            .bold()
                        //                            .foregroundStyle(.white)
                        //                        List(characterItem.episodesList, id: \.self) { episode in
                        //                            Text(episode)
                        //                                .font(.system(size: 16))
                        //                                .tint(.white)
                        //                        }
                        //                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
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
                .background(viewModel.showLoading ? .clear : .rmGreyLight)
                .scrollContentBackground(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .contentMargins(0, for: .automatic)
        }
    }
}
