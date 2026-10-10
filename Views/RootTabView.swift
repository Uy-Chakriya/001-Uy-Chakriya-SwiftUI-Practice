import SwiftUI

struct RootTabView: View {
    @State private var store = AppStore()
    
    var body: some View {
        TabView {
            RecipeHomeView()
                .tabItem {
                    Label("Browse", systemImage: "square.grid.2x2")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            
            PlanView()
                .tabItem {
                    Label("Plan", systemImage: "calendar")
                }
            
            ShoppingView()
                .tabItem {
                    Label("Shopping", systemImage: "checklist")
                }
        }
        .environment(store)
        .tint(Color(#colorLiteral(red: 0.768627451, green: 0.2823529412, blue: 0.1764705882, alpha: 1)))
    }
}
