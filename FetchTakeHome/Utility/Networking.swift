import Foundation

protocol NetworkingProtocol {
    func fetchDesserts() async throws -> Desserts
    func fetchDessertDetails(by id: String) async throws -> DessertRecipes
}

class Networking: NetworkingProtocol {

    static let shared = Networking()
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchDesserts() async throws -> Desserts {
        let endpoint = APIEndpoints.dessertListURL
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidResponse
        }
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Desserts.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func fetchDessertDetails(by id: String) async throws -> DessertRecipes {
        let endpoint = APIEndpoints.mealLookupURL(for: id)
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidResponse
        }
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(DessertRecipes.self, from: data)
    }
}
