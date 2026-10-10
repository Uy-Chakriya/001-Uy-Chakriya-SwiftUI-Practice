import SwiftUI

struct RecipeCard: View {
    @Environment(AppStore.self) private var store
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {

                Image(recipe.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .cornerRadius(12)
                    .clipped()
                
                Button(action: {
                    store.toggleFavorite(recipeID: recipe.id)
                }) {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(recipe.isFavorite ? .red : .gray)
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            Text(recipe.name)
                .font(.headline)
                .lineLimit(1)
            
            Text("\(recipe.cookingTime) • \(recipe.category)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
