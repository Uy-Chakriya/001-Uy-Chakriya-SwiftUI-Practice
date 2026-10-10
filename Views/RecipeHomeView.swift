import SwiftUI

struct RecipeHomeView: View {
    @Environment(AppStore.self) private var store
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    @State private var showingNewRecipeSheet = false
    
    let categories = ["All", "Breakfast", "Lunch", "Dinner", "Quick"]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var filteredRecipes: [Recipe] {
        store.recipes.filter { recipe in
            let matchesSearch = searchText.isEmpty || recipe.name.localizedStandardContains(searchText)
            let matchesCategory = selectedCategory == "All" || recipe.category.lowercased() == selectedCategory.lowercased()
            return matchesSearch && matchesCategory
        }
    }
    
    var body: some View {
        NavigationStack {
            // ScrollView wraps the content so the user can scroll up and down
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header and Add Button
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("THURSDAY, OCT 1")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                            
                            Text("What's cooking?")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        
                        Button(action: { showingNewRecipeSheet = true }) {
                            Image(systemName: "plus")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color(#colorLiteral(red: 0.768627451, green: 0.2823529412, blue: 0.1764705882, alpha: 1)))
                                .clipShape(Circle())
                        }
                    }
                    
                    //====>>> Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search recipes", text: $searchText)
                    }
                    .padding(12)
                    .background(Color.secondary.opacity(0.12))
                    .cornerRadius(10)
                    
                    // ====>>> Horizontal scrolling ==
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: { selectedCategory = category }) {
                                    Text(category)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(selectedCategory == category ? Color.black : Color.secondary.opacity(0.12))
                                        .foregroundColor(selectedCategory == category ? .white : .primary)
                                        .cornerRadius(20)
                                }
                            }
                        }
                    }
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredRecipes) { recipe in
                            NavigationLink(value: recipe) {
                                RecipeCard(recipe: recipe)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    Spacer()
                        .frame(height: 150)
                }
                .padding()
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .sheet(isPresented: $showingNewRecipeSheet) {
                NewRecipeView()
            }
        }
    }
}
