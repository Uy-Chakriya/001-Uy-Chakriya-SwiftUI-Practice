import Foundation

struct MethodStep: Identifiable, Codable, Hashable {
    let id = UUID()
    let stepNumber: Int
    let instruction: String
}
