import SwiftUI

struct RecipeDetailView: View {
    @Environment(AppStore.self) private var store
    let recipe: Recipe
    @State private var servings: Int
    @State private var showingCookingMode = false
    @State private var showingPlanDialog = false
    
    var liveRecipe: Recipe {
        store.recipes.first(where: { $0.id == recipe.id }) ?? recipe
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
        _servings = State(initialValue: recipe.baseServings)
    }
    
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Hero banner header image
                ZStack(alignment: .topTrailing) {
                    Image(liveRecipe.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 220)
                        .clipped()
                    
                    Button(action: {
                        store.toggleFavorite(recipeID: liveRecipe.id)
                    }) {
                        Image(systemName: liveRecipe.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(liveRecipe.isFavorite ? .red : .gray)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                    .padding(16)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(liveRecipe.category.uppercased())
                            .font(.caption)
                            .bold()
                            .foregroundColor(.orange)
                        Spacer()
                    }
                    
                    Text(liveRecipe.name)
                        .font(.title)
                        .bold()
                    
                    Text(liveRecipe.description)
                        .foregroundColor(.secondary)
                    
                    ServingControl(servings: $servings)
                    
                    HStack {
                        Text("Ingredients")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Text("\(liveRecipe.ingredients.count) items")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    ForEach(liveRecipe.ingredients) { ingredient in
                        HStack {
                            let scaledAmount = (ingredient.baseAmount / Double(liveRecipe.baseServings)) * Double(servings)
                            Text(scaledAmount.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(scaledAmount))" : String(format: "%.1f", scaledAmount))
                                .bold()
                                .foregroundColor(Color(#colorLiteral(red: 0.768627451, green: 0.2823529412, blue: 0.1764705882, alpha: 1)))
                            Text(ingredient.unit)
                            Text(ingredient.name)
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .background(Color.secondary.opacity(0.05))
                        .cornerRadius(8)
                    }
                    
                    Text("Method")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    
                    ForEach(liveRecipe.methods) { method in
                        MethodStepCard(method: method)
                    }
                    
                    Spacer().frame(height: 40)
                }
                .padding(.horizontal)
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 12) {
                Button(action: { showingPlanDialog = true }) {
                    Label("Add to plan", systemImage: "calendar")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color.secondary.opacity(0.15))
                        .cornerRadius(12)
                }
                
                Button(action: { showingCookingMode = true }) {
                    Text("Start cooking")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(#colorLiteral(red: 0.768627451, green: 0.2823529412, blue: 0.1764705882, alpha: 1)))
                        .cornerRadius(12)
                }
            }
            .padding()
            .background(.ultraThinMaterial)
        }
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showingCookingMode) {
            CookingModeView(recipe: liveRecipe, isPresented: $showingCookingMode)
        }
        .confirmationDialog("Add \(liveRecipe.name) to...", isPresented: $showingPlanDialog, titleVisibility: .visible) {
            ForEach(daysOfWeek, id: \.self) { day in
                Button(day == "Mon" ? "Monday, Oct 5" :
                       day == "Tue" ? "Tuesday, Oct 6" :
                       day == "Wed" ? "Wednesday, Oct 7" :
                       day == "Thu" ? "Thursday, Oct 8" :
                       day == "Fri" ? "Friday, Oct 9" :
                       day == "Sat" ? "Saturday, Oct 10" : "Sunday, Oct 11") {
                    store.assignMeal(day: day, recipe: liveRecipe)
                }
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}
