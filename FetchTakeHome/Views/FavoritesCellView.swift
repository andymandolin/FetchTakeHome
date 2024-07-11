import SwiftUI

struct FavoritesCellView: View {
    var imageURL: URL?
    
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
            ProgressView()
        }
    }
}
