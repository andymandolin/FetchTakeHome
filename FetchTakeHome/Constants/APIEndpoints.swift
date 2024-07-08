import Foundation

enum APIEndpoints {
    static let dessertListURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    static func mealLookupURL(for id: String) -> String {
        return "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
    }
}
