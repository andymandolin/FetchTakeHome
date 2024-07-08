import Foundation

struct DessertRecipes: Decodable {
    let meals: [DessertRecipe]
}

struct Ingredient {
    let name: String
    let measure: String
}

struct DessertRecipe: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    
    var ingredients: [(name: String, measure: String)] {
        var results = [(name: String, measure: String)]()
        
        let mirror = Mirror(reflecting: self)
        for i in 1...10 {
            if let ingredient = mirror.children.first(where: { $0.label == "strIngredient\(i)" })?.value as? String,
               let measure = mirror.children.first(where: { $0.label == "strMeasure\(i)" })?.value as? String,
               !ingredient.isEmpty {
                results.append((name: ingredient, measure: measure))
            }
        }
        return results
    }
    
}
