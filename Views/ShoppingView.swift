import SwiftUI

struct ShoppingView: View {
    @Environment(AppStore.self) private var store
    @State private var checkedItems: Set<UUID> = []
    
    var aggregatedIngredients: [String: [Ingredient]] {
        var dict = [String: [Ingredient]]()
        for (_, recipe) in store.plannedMeals {
            for ing in recipe.ingredients {
                let section = ing.section
                dict[section, default: []].append(ing)
            }
        }
        return dict
    }
    
    var totalItemsCount: Int {
        aggregatedIngredients.values.reduce(0) { $0 + $1.count }
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Shopping")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("\(totalItemsCount - checkedItems.count) of \(totalItemsCount) left • from \(store.plannedMeals.count) planned meals")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        
                        if !checkedItems.isEmpty {
                            Button(action: {
                                checkedItems.removeAll()
                            }) {
                                Text("Uncheck all")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(#colorLiteral(red: 0.768627451, green: 0.2823529412, blue: 0.1764705882, alpha: 1)))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.secondary.opacity(0.12))
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(Array(aggregatedIngredients.keys.sorted()), id: \.self) { sectionName in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(sectionName)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                
                                VStack(spacing: 0) {
                                    if let ingredients = aggregatedIngredients[sectionName] {
                                        ForEach(Array(ingredients.enumerated()), id: \.offset) { index, ingredient in
                                            let isChecked = checkedItems.contains(ingredient.id)
                                            
                                            Button(action: {
                                                if isChecked {
                                                    checkedItems.remove(ingredient.id)
                                                } else {
                                                    checkedItems.insert(ingredient.id)
                                                }
                                            }) {
                                                HStack(alignment: .center, spacing: 12) {
                                                    ZStack {
                                                        Circle()
                                                            .stroke(isChecked ? Color(#colorLiteral(red: 0.768627451, green: 0.2823529412, blue: 0.1764705882, alpha: 1)) : Color.gray.opacity(0.4), lineWidth: 1.5)
                                                            .frame(width: 24, height: 24)
                                                        
                                                        if isChecked {
                                                            Circle()
                                                                .fill(Color(#colorLiteral(red: 0.768627451, green: 0.2823529412, blue: 0.1764705882, alpha: 1)))
                                                                .frame(width: 24, height: 24)
                                                            Image(systemName: "checkmark")
                                                                .font(.caption2)
                                                                .fontWeight(.bold)
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    
                                                    VStack(alignment: .leading, spacing: 2) {
                                                        Text(ingredient.name)
                                                            .font(.body)
                                                            .strikethrough(isChecked, color: .secondary)
                                                            .foregroundColor(isChecked ? .secondary : .primary)
                                                        
                                                        Text("Recipe item")
                                                            .font(.caption2)
                                                            .foregroundColor(.secondary)
                                                    }
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(Int(ingredient.baseAmount)) \(ingredient.unit)")
                                                        .font(.subheadline)
                                                        .foregroundColor(.secondary)
                                                }
                                                .padding()
                                                .background(Color.secondary.opacity(0.06))
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                            
                                            if index < ingredients.count - 1 {
                                                Divider()
                                                    .padding(.leading, 50)
                                            }
                                        }
                                    }
                                }
                                .background(Color.secondary.opacity(0.06))
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                        .frame(height: 90)
                }
                .padding(.top)
            }
        }
    }
}
