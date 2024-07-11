import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) private var context
    @Query var destinations: [FavoriteDessertIds]
    
    @StateObject private var viewModel = DetailViewModel()
    let dessert: Dessert
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Colors.grayBackground
                    .ignoresSafeArea()
                VStack {
                    if let detailedDessert = viewModel.dessertRecipe {
                        ScrollView {
                            VStack(alignment: .center, spacing: 16) {
                                Text(dessert.strMeal)
                                    .font(Fonts.avenirLight46)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(Colors.label)
                                    .padding(.horizontal)
                                ZStack {
                                    AsyncImage(url: URL(string: detailedDessert.strMealThumb)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } placeholder: {
                                        ProgressView()
                                            .frame(maxWidth: .infinity, maxHeight: 400)
                                    }
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                if isFavoriteDessert() {
                                                    if let test = findMatchingDestination()  {
                                                        context.delete(test)
                                                    }
                                                } else {
                                                    let test = FavoriteDessertIds(id: [dessert.idMeal])
                                                    context.insert(test)
                                                }
                                                do {
                                                    try context.save()
                                                } catch {
                                                    print(error.localizedDescription)
                                                }
                                            }) {
                                                Image(systemName: isFavoriteDessert() ? "heart.fill" : "heart")
                                                    .foregroundColor(.white)
                                                    .padding()
                                            }
                                            .background(Colors.favoritingBackground)
                                            .clipShape(Circle())
                                            .padding()
                                        }
                                    }
                                }
                                VStack {
                                    Text("Instructions:")
                                        .font(Fonts.avenirLight16)
                                        .padding(.vertical, 8)
                                        .foregroundColor(Colors.label)
                                    Text(detailedDessert.strInstructions)
                                        .foregroundColor(Colors.label)
                                        .font(Fonts.avenirLight16)
                                }
                                .padding()
                                .background(Colors.whiteBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                VStack {
                                    Text("Ingredients:")
                                        .font(Fonts.headline)
                                        .padding(.vertical, 8)
                                        .foregroundColor(Colors.label)
                                    ForEach(detailedDessert.ingredients, id: \.0) { ingredient in
                                        HStack {
                                            Text(ingredient.name)
                                                .foregroundColor(Colors.label)
                                                .font(Fonts.avenirLight16)
                                            Spacer()
                                            Text(ingredient.measure)
                                                .foregroundColor(Colors.label)
                                                .font(Fonts.avenirLight16)
                                        }
                                    }
                                }
                                .padding()
                                .background(Colors.whiteBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: geometry.size.width * 0.96)
                        }
                    } else {
                        ProgressView()
                            .task {
                                await viewModel.fetchDessertDetails(by: dessert.idMeal)
                            }
                            .alert(item: $viewModel.errorMessage) { errorMessage in
                                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                            }
                    }
                }
            }
        }
    }

    private func isFavoriteDessert() -> Bool {
        for favoriteIds in destinations {
            if favoriteIds.id.contains(dessert.idMeal) {
                return true
            }
        }
        return false
    }

    private func findMatchingDestination() -> FavoriteDessertIds? {
        for destination in destinations {
            if destination.id.contains(dessert.idMeal) {
                return destination
            }
        }
        return nil
    }
}

