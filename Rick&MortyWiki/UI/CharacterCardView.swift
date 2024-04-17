import SwiftUI

struct CharacterCardView: View {
    let item: CharacterViewItem
    
    var body: some View {
        VStack {
            AsyncImage(url: item.imageUrl,
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
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text(item.name.capitalized)
                .font(.headline)
                .bold()
                .tint(.white)
            Text(item.description)
                .font(.subheadline)
                .tint(.white)
            Text(item.species)
                .font(.subheadline)
                .tint(.white)
        }
        .padding()
        .background(Color.rmGreyLight)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
