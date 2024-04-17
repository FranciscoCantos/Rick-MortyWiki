import SwiftUI

struct CharacterDetailComponentView: View {
    private let characterItem: CharacterDetailViewItem
    
    init(characterItem: CharacterDetailViewItem) {
        self.characterItem = characterItem
    }
    
    var body: some View {
        ScrollView {
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
        .background(Color.rmGreyLight)
    }
}

#Preview {
    CharacterDetailComponentView(characterItem:
                                    CharacterDetailViewItem(model:
                                                                CharacterInfo(id: 000,
                                                                              name: "Kurro",
                                                                              imageURL: URL(string: "https://gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"),
                                                                              status: .alive,
                                                                              species: "Humana",
                                                                              url: URL(string: "https://www.apple.com"),
                                                                              type: "aaaa",
                                                                              gender: .female,
                                                                              origin: "AAAA",
                                                                              location: "caceres",
                                                                              episodesList: ["Uno", "Dos", "tres"],
                                                                              createdDate: Date.now)))
}
