import SwiftUI

struct MethodStepCard: View {
    let method: MethodStep
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(method.stepNumber)")
                .bold()
                .frame(width: 24, height: 24)
                .background(Color.orange.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(method.instruction)
                    .foregroundColor(.primary)
                Text("8 min timer")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.secondary.opacity(0.08))
        .cornerRadius(12)
    }
}
