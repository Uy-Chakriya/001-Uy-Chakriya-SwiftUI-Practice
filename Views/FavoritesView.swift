import SwiftUI

struct FavoritesView: View {
    @Environment(AppStore.self) private var store
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Favorites")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("\(store.favorites.count) saved recipes")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    VStack(spacing: 12) {
                        ForEach(store.favorites) { recipe in
                            NavigationLink(value: recipe) {
                                HStack(spacing: 12) {
                                    // Displays the real custom image from Assets.xcassets
                                    Image(recipe.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(8)
                                        .clipped()
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(recipe.name)
                                            .font(.headline)
                                        Text("\(recipe.cookingTime) • \(recipe.category)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        store.toggleFavorite(recipeID: recipe.id)
                                    }) {
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding()
                                .background(Color.secondary.opacity(0.08))
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    Spacer().frame(height: 90)
                }
                .padding()
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
    }
}
