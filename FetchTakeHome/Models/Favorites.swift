import SwiftData

@Model
class FavoriteDessertIds {
    var id: [String]
    
    init(id: [String]) {
        self.id = id
    }
}

