import SwiftUI

struct CharacterCardView: View {
    let item: CharacterViewItem
    
    var body: some View {
        VStack {
            AsyncImage(url: item.imageUrl,
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
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            Text(item.name.capitalized)
                .font(.system(size: 12))
                .bold()
                .tint(.white)
            Text(item.description)
                .font(.system(size: 10))
                .tint(.white)
            Text(item.species)
                .font(.system(size: 10))
                .tint(.white)
        }
        .padding()
        .background(Color.rmGreyLight)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
