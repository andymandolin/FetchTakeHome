import Foundation

final class DetailViewModel: ObservableObject {
    @Published var dessertRecipe: DessertRecipe?
    @Published var errorMessage: String?
    
    let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol = Networking.shared) {
        self.networking = networking
    }
    
    func fetchDessertDetails(by id: String) async {
        do {
            let mealsResponse = try await networking.fetchDessertDetails(by: id)
            DispatchQueue.main.async {
                self.dessertRecipe = mealsResponse.meals.first
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
