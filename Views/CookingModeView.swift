import SwiftUI

struct CookingModeView: View {
    let recipe: Recipe
    @Binding var isPresented: Bool
    @State private var currentStepIndex = 0
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1137254902, green: 0.1058823529, blue: 0.09803921569, alpha: 1))
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                // Top header
                HStack {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.white.opacity(0.15))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 2) {
                        Text(recipe.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Step \(currentStepIndex + 1) of \(recipe.methods.count)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    Color.clear.frame(width: 40)
                }
                
                // Progress dashes
                HStack(spacing: 6) {
                    ForEach(0..<recipe.methods.count, id: \.self) { index in
                        Rectangle()
                            .fill(index <= currentStepIndex ? Color.orange : Color.gray.opacity(0.4))
                            .frame(height: 3)
                            .cornerRadius(1.5)
                    }
                }
                
                if !recipe.methods.isEmpty {
                    let method = recipe.methods[currentStepIndex]
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Step 0\(method.stepNumber)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        
                        Text(method.instruction)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                }
                
                Spacer()
                
                // Bottom controls
                HStack(spacing: 16) {
                    if currentStepIndex > 0 {
                        Button(action: { currentStepIndex -= 1 }) {
                            Text("Back")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(25)
                        }
                    }
                    
                    Button(action: {
                        if currentStepIndex < recipe.methods.count - 1 {
                            currentStepIndex += 1
                        } else {
                            isPresented = false
                        }
                    }) {
                        Text(currentStepIndex < recipe.methods.count - 1 ? "Next step" : "Finish")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color(#colorLiteral(red: 0.768627451, green: 0.2823529412, blue: 0.1764705882, alpha: 1)))
                            .cornerRadius(25)
                    }
                }
            }
            .padding()
        }
    }
}
