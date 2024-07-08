import Foundation

struct Desserts: Codable, Equatable {
    let meals: [Dessert]
}

struct Dessert: Codable, Identifiable, Hashable {
    var id: String
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.id = idMeal
    }
    
    init(id: String, strMeal: String, strMealThumb: String, idMeal: String) {
        self.id = id
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
}
