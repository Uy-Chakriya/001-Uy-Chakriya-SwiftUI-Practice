import SwiftUI

struct NewRecipeView: View {
    @Environment(AppStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var category = "Dinner"
    @State private var cookingTime = "20 min"
    @State private var description = ""
    @State private var showingDiscardAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Recipe Name", text: $name)
                TextField("Category (e.g. Dinner)", text: $category)
                TextField("Cooking Time (e.g. 20 min)", text: $cookingTime)
                TextField("Description", text: $description)
            }
            .navigationTitle("New Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("X") {
                        if !name.isEmpty || !description.isEmpty {
                            showingDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newRecipe = Recipe(
                            name: name.isEmpty ? "Untitled Recipe" : name,
                            category: category,
                            cookingTime: cookingTime,
                            baseServings: 2,
                            imageName: "fork.knife",
                            description: description,
                            isFavorite: false,
                            ingredients: [Ingredient(name: "Salt", baseAmount: 1, unit: "pinch", section: "PANTRY")],
                            methods: [MethodStep(stepNumber: 1, instruction: "Cook and enjoy!")]
                        )
                        store.recipes.insert(newRecipe, at: 0)
                        dismiss()
                    }
                }
            }
            .alert("Discard this recipe?", isPresented: $showingDiscardAlert) {
                Button("Discard", role: .destructive) { dismiss() }
                Button("Keep editing", role: .cancel) {}
            }
        }
    }
}
