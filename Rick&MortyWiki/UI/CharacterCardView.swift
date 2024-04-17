import SwiftUI

struct CharacterCardView: View {
    let item: CharacterViewItem
    
    var body: some View {
        VStack {
            AsyncImage(url: item.imageUrl) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image("PlaceholderImage").resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    ProgressView().progressViewStyle(.circular)
                }
            }
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
