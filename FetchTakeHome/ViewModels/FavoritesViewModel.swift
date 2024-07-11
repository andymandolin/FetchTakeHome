import Foundation

final class FavoritesViewModel: ObservableObject {
    @Published var desserts: [Dessert] = []
    @Published var errorMessage: String?
    
    let networking: NetworkingProtocol

    init(networking: NetworkingProtocol = Networking.shared) {
        self.networking = networking
    }
    
    func fetchDesserts() async {
        do {
            let mealsResponse = try await networking.fetchDesserts()
            let mealsResponseSortedAlphabetically = mealsResponse.meals
                .filter { meal in
                      return !meal.id.isEmpty &&
                             !meal.strMeal.isEmpty &&
                             !meal.strMealThumb.isEmpty &&
                             !meal.idMeal.isEmpty
                  }
                .map { meal -> Dessert in
                    let capitalizedStrMeal = meal.strMeal
                        .lowercased()
                        .split(separator: " ")
                        .map { $0.capitalized }
                        .joined(separator: " ")
                    return Dessert(id: meal.id,
                                   strMeal: capitalizedStrMeal,
                                   strMealThumb: meal.strMealThumb,
                                   idMeal: meal.idMeal)
                }
                  .sorted { $0.strMeal < $1.strMeal }
            DispatchQueue.main.async {
                self.desserts = mealsResponseSortedAlphabetically
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
