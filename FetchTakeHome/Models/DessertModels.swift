import Foundation

struct Desserts: Decodable, Equatable {
    let meals: [Dessert]
}

class Dessert: Decodable, Identifiable, Hashable {
    var id: String
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.id = try container.decode(String.self, forKey: .idMeal)
    }
    
    init(id: String, strMeal: String, strMealThumb: String, idMeal: String) {
        self.id = id
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Dessert, rhs: Dessert) -> Bool {
        return lhs.id == rhs.id
    }
}
