import SwiftUI

struct IngredientRow: View {
    let ingredient: Ingredient
    let baseServings: Int
    let currentServings: Int
    
    var body: some View {
        HStack {
            let scaledAmount = (ingredient.baseAmount / Double(baseServings)) * Double(currentServings)
            Text(scaledAmount.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(scaledAmount))" : String(format: "%.1f", scaledAmount))
                .bold()
            Text(ingredient.unit)
            Text(ingredient.name)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
