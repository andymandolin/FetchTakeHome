import SwiftUI
import SwiftData

struct BottomSheetView: View {
    @Environment(\.modelContext) private var context
    @Query var favoriteDessertIds: [FavoriteDessertIds]
    @Binding var isPresented: Bool
    @Binding var selectedDessert: Dessert?
    @StateObject private var viewModel = FavoritesViewModel()
    
    private var filteredFavoritedDesserts: [Dessert] {
        let favoriteIdsSet = Set(favoriteDessertIds.flatMap { $0.id })
        return viewModel.desserts.filter { favoriteIdsSet.contains($0.idMeal) }
    }
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    
    var body: some View {
        ScrollView {
            Text("Favorites")
                .font(Fonts.avenirBold32)
                .foregroundColor(Colors.label)
                .padding()
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(filteredFavoritedDesserts) { dessert in
                    FavoritesCellView(imageURL: URL(string: dessert.strMealThumb))
                        .aspectRatio(1.0, contentMode: .fit)
                        .onTapGesture {
                            selectedDessert = dessert
                            isPresented = false
                        }
                }
            }
            .padding(16)
        }
        .task {
            await viewModel.fetchDesserts()
        }
    }
}
