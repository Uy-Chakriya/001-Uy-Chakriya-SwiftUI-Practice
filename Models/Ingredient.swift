import Foundation

struct Ingredient: Identifiable, Codable, Hashable {
    let id = UUID()
    let name: String
    let baseAmount: Double
    let unit: String
    var isChecked: Bool = false
    var section: String = "PRODUCE"
}
