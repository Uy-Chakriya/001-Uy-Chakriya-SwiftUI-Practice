import SwiftUI

struct ServingControl: View {
    @Binding var servings: Int
    
    var body: some View {
        HStack {
            Text("Servings")
                .font(.headline)
            Spacer()
            
            Button(action: { if servings > 1 { servings -= 1 } }) {
                Image(systemName: "minus")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            
            Text("\(servings)")
                .font(.headline)
                .frame(minWidth: 30)
            
            Button(action: { servings += 1 }) {
                Image(systemName: "plus")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.12))
        .cornerRadius(12)
    }
}
