import SwiftUI

struct PlanView: View {
    @Environment(AppStore.self) private var store
    let days = [
        ("Mon", "5"), ("Tue", "6"), ("Wed", "7"),
        ("Thu", "8"), ("Fri", "9"), ("Sat", "10"), ("Sun", "11")
    ]
    
    @State private var pickerDay: String? = nil
    @State private var pickerDayFullname: String = ""
    @State private var showingPickerSheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("This week")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Oct 5 – 11 • \(store.plannedMeals.count) meals planned")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    VStack(spacing: 12) {
                        ForEach(days, id: \.0) { dayTuple in
                            let dayName = dayTuple.0
                            let dayNum = dayTuple.1
                            
                            HStack(alignment: .top, spacing: 16) {
                                VStack(spacing: 2) {
                                    Text(dayName.uppercased())
                                        .font(.caption2)
                                        .bold()
                                        .foregroundColor(.secondary)
                                    Text(dayNum)
                                        .font(.title3)
                                        .bold()
                                }
                                .frame(width: 32)
                                
                                if let recipe = store.plannedMeals[dayName] {
                                    HStack(spacing: 12) {
                                        // Real image asset for planned meal row
                                        Image(recipe.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 36, height: 36)
                                            .cornerRadius(6)
                                            .clipped()
                                        
                                        Text(recipe.name)
                                            .fontWeight(.medium)
                                        
                                        Spacer()
                                        
                                        Button(action: { store.removeMeal(day: dayName) }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.secondary.opacity(0.6))
                                                .font(.title3)
                                        }
                                    }
                                    .padding(10)
                                    .background(Color.secondary.opacity(0.08))
                                    .cornerRadius(12)
                                } else {
                                    Button(action: {
                                        pickerDay = dayName
                                        pickerDayFullname = dayName == "Mon" ? "Monday, Oct 5" :
                                                            dayName == "Tue" ? "Tuesday, Oct 6" :
                                                            dayName == "Wed" ? "Wednesday, Oct 7" :
                                                            dayName == "Thu" ? "Thursday, Oct 8" :
                                                            dayName == "Fri" ? "Friday, Oct 9" :
                                                            dayName == "Sat" ? "Saturday, Oct 10" : "Sunday, Oct 11"
                                        showingPickerSheet = true
                                    }) {
                                        HStack {
                                            Text("Add a meal")
                                                .foregroundColor(.secondary)
                                            Spacer()
                                            Image(systemName: "plus.circle")
                                                .foregroundColor(.secondary)
                                        }
                                        .padding(12)
                                        .background(Color.secondary.opacity(0.05))
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                                .foregroundColor(.secondary.opacity(0.3))
                                        )
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("FAVORITES • DRAG ONTO A DAY, OR TAP")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.secondary)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(store.favorites) { recipe in
                                    Button(action: {
                                        if let firstEmpty = days.map({ $0.0 }).first(where: { store.plannedMeals[$0] == nil }) {
                                            store.assignMeal(day: firstEmpty, recipe: recipe)
                                        }
                                    }) {
                                        // Real image asset in favorites bottom tray
                                        Image(recipe.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(10)
                                            .clipped()
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer().frame(height: 90)
                }
                .padding()
            }
            .sheet(isPresented: $showingPickerSheet) {
                NavigationStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Add to \(pickerDayFullname)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 12)
                        
                        Divider()
                        
                        List(store.recipes) { recipe in
                            Button(action: {
                                if let day = pickerDay {
                                    store.assignMeal(day: day, recipe: recipe)
                                }
                                showingPickerSheet = false
                            }) {
                                HStack(spacing: 16) {
                                    // Real image asset in recipe picker sheet
                                    Image(recipe.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 32, height: 32)
                                        .cornerRadius(6)
                                        .clipped()
                                    
                                    Text(recipe.name)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .listStyle(.plain)
                    }
                    .navigationTitle("Select a recipe")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}
