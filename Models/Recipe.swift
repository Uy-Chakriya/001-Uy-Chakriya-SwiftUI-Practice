import Foundation

struct Recipe: Identifiable, Codable, Hashable {
    let id = UUID()
    let name: String
    let category: String
    let cookingTime: String
    let baseServings: Int
    let imageName: String
    let description: String
    var isFavorite: Bool
    var ingredients: [Ingredient]
    var methods: [MethodStep]
}
