import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject private var viewModel: CharactersDetailViewModel
    
    init(viewModel: CharactersDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack{
            ScrollView {
                if let characterItem = viewModel.characterItem {
                    AsyncImage(url: characterItem.imageUrl,
                               content: { image in
                        if let image = image.image {
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } else if image.error != nil {
                            Image("Placeholder")
                        } else {
                            ProgressView().progressViewStyle(.circular)
                        }
                    })
                    Text(characterItem.name)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    Text(characterItem.description)
                        .font(.title2)
                        .foregroundStyle(.white)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Specie:")
                                .font(.system(size: 14))
                                .bold()
                                .foregroundStyle(.white)
                            Text("Gender:")
                                .font(.system(size: 14))
                                .bold()
                                .foregroundStyle(.white)
                            Text("Origin:")
                                .font(.system(size: 14))
                                .bold()
                                .foregroundStyle(.white)
                            Text("Location:")
                                .font(.system(size: 14))
                                .bold()
                                .foregroundStyle(.white)
                            Text("Creation Date:")
                                .font(.system(size: 14))
                                .bold()
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(characterItem.species)
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            Text(characterItem.gender.rawValue.capitalized)
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            Text(characterItem.origin)
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            Text(characterItem.location)
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            Text(characterItem.createdDate?.formatted() ?? "Not Available")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    VStack(alignment: .leading) {
                        Text("Episodes:")
                            .font(.system(size: 14))
                            .bold()
                            .foregroundStyle(.white)
                        List(characterItem.episodesList, id: \.self) { episode in
                            Text(episode)
                                .font(.system(size: 14))
                                .tint(.white)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    if let linkUrl = characterItem.url {
                        Link(destination: linkUrl) {
                            Image(systemName: "link.circle.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                    }
                }
                }.onAppear {
                        viewModel.onAppear()
                    }
            
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
                }
            }
        }.background(Color.rmGreyDark)
    }
}
