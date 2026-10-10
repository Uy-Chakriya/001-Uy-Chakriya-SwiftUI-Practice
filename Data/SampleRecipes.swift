import Foundation

struct SampleData {
    static let recipes = [
        Recipe(
            name: "Fish Amok",
            category: "Dinner",
            cookingTime: "45 min",
            baseServings: 2,
            imageName: "fish_amok",
            description: "Traditional Cambodian steamed fish curry wrapped in banana leaves with coconut milk and kroeung.",
            isFavorite: true,
            ingredients: [
                Ingredient(name: "fish fillets", baseAmount: 300, unit: "g", section: "MEAT & FISH"),
                Ingredient(name: "coconut milk", baseAmount: 200, unit: "ml", section: "PANTRY"),
                Ingredient(name: "kroeung paste", baseAmount: 2, unit: "tbsp", section: "PRODUCE"),
                Ingredient(name: "noni leaves", baseAmount: 5, unit: "", section: "PRODUCE"),
                Ingredient(name: "fish sauce", baseAmount: 1, unit: "tbsp", section: "PANTRY")
            ],
            methods: [
                MethodStep(stepNumber: 1, instruction: "Blend the kroeung paste with coconut milk and fish sauce."),
                MethodStep(stepNumber: 2, instruction: "Mix with fish pieces and steam in banana leaf cups until set.")
            ]
        ),
        Recipe(
            name: "Beef Lok Lak",
            category: "Lunch",
            cookingTime: "20 min",
            baseServings: 2,
            imageName: "beef_loklak", 
            description: "Stir-fried tender beef cubes served on a bed of lettuce, tomatoes, and lime-black pepper dip.",
            isFavorite: true,
            ingredients: [
                Ingredient(name: "beef tenderloin", baseAmount: 300, unit: "g", section: "MEAT & FISH"),
                Ingredient(name: "lettuce", baseAmount: 1, unit: "head", section: "PRODUCE"),
                Ingredient(name: "tomato", baseAmount: 2, unit: "", section: "PRODUCE"),
                Ingredient(name: "black pepper", baseAmount: 1, unit: "tsp", section: "PANTRY"),
                Ingredient(name: "lime juice", baseAmount: 2, unit: "tbsp", section: "PRODUCE")
            ],
            methods: [
                MethodStep(stepNumber: 1, instruction: "Marinate beef cubes with garlic, soy sauce, and oyster sauce."),
                MethodStep(stepNumber: 2, instruction: "Quickly sear over high heat and serve over fresh vegetables.")
            ]
        ),
        Recipe(
            name: "Nom Banh Chok",
            category: "Breakfast",
            cookingTime: "30 min",
            baseServings: 2,
            imageName: "nom_banhchok",
            description: "Khmer noodles served with a fragrant greenish fish gravy and fresh crunchy herbs.",
            isFavorite: false,
            ingredients: [
                Ingredient(name: "rice noodles", baseAmount: 250, unit: "g", section: "PANTRY"),
                Ingredient(name: "fish gravy", baseAmount: 300, unit: "ml", section: "MEAT & FISH"),
                Ingredient(name: "cucumber", baseAmount: 1, unit: "", section: "PRODUCE"),
                Ingredient(name: "bean sprouts", baseAmount: 100, unit: "g", section: "PRODUCE")
            ],
            methods: [
                MethodStep(stepNumber: 1, instruction: "Prepare fresh fish gravy with lemongrass and kaffir lime.")
            ]
        ),
        Recipe(
            name: "Bai Sach Chrouk",
            category: "Breakfast",
            cookingTime: "25 min",
            baseServings: 2,
            imageName: "bai_sachchrouk",
            description: "Grilled marinated pork served over warm broken rice with pickled vegetables.",
            isFavorite: false,
            ingredients: [
                Ingredient(name: "pork chop", baseAmount: 2, unit: "", section: "MEAT & FISH"),
                Ingredient(name: "broken rice", baseAmount: 200, unit: "g", section: "PANTRY"),
                Ingredient(name: "garlic", baseAmount: 2, unit: "cloves", section: "PRODUCE")
            ],
            methods: [
                MethodStep(stepNumber: 1, instruction: "Marinate pork in palm sugar, garlic, and fish sauce, then grill.")
            ]
        ),
        Recipe(
            name: "Samlor Korkor",
            category: "Dinner",
            cookingTime: "40 min",
            baseServings: 4,
            imageName: "samlor_korkor",
            description: "Traditional Cambodian stirring soup packed with local vegetables, green papaya, and catfish.",
            isFavorite: false,
            ingredients: [
                Ingredient(name: "catfish", baseAmount: 250, unit: "g", section: "MEAT & FISH"),
                Ingredient(name: "green papaya", baseAmount: 100, unit: "g", section: "PRODUCE"),
                Ingredient(name: "long beans", baseAmount: 5, unit: "", section: "PRODUCE")
            ],
            methods: [
                MethodStep(stepNumber: 1, instruction: "Sauté kroeung paste, add vegetables, fish, and simmer.")
            ]
        ),
        Recipe(
            name: "Num Ansorm",
            category: "Quick",
            cookingTime: "15 min",
            baseServings: 2,
            imageName: "num_ansorm",
            description: "Sweet sticky rice cake wrapped in banana leaves.",
            isFavorite: false,
            ingredients: [
                Ingredient(name: "sticky rice", baseAmount: 200, unit: "g", section: "PANTRY"),
                Ingredient(name: "banana leaves", baseAmount: 2, unit: "", section: "PRODUCE")
            ],
            methods: [
                MethodStep(stepNumber: 1, instruction: "Wrap rice and banana filling tightly and steam.")
            ]
        )
    ]
}

@Observable
class AppStore {
    var recipes: [Recipe] = SampleData.recipes
    var plannedMeals: [String: Recipe] = [
        "Mon": SampleData.recipes[0],
        "Wed": SampleData.recipes[1],
        "Thu": SampleData.recipes[2],
        "Sat": SampleData.recipes[3]
    ]
    
    var favorites: [Recipe] {
        recipes.filter { $0.isFavorite }
    }
    
    func toggleFavorite(recipeID: UUID) {
        if let index = recipes.firstIndex(where: { $0.id == recipeID }) {
            recipes[index].isFavorite.toggle()
        }
    }
    
    func assignMeal(day: String, recipe: Recipe) {
        plannedMeals[day] = recipe
    }
    
    func removeMeal(day: String) {
        plannedMeals.removeValue(forKey: day)
    }
}
