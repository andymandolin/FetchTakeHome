import Foundation

class MockNetworking: NetworkingProtocol {
    var shouldThrowError = false
    var mockMealsResponse: Desserts?
    var mockDetailedDessertsResponse: DessertRecipes?

    func fetchDesserts() async throws -> Desserts {
        if shouldThrowError {
            throw NetworkError.invalidResponse
        } else {
            return mockMealsResponse ?? Desserts(meals: [])
        }
    }
    
    func fetchDessertDetails(by id: String) async throws -> DessertRecipes {
        if shouldThrowError {
            throw NetworkError.invalidResponse
        } else {
            return mockDetailedDessertsResponse ?? DessertRecipes(meals: [])
        }
    }
}


