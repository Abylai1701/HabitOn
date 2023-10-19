import Foundation

struct CreateGoalModel: Loopable, Codable {
    let name: String
    let iteration_count: Int
    let days: [String]
}
