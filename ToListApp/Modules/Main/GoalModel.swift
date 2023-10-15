import Foundation

struct GoalModel: Codable {
    let id: Int
    let name, pushTime: String
    let iterationCount: Int
    let days: [String]
    let currentSeries: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case pushTime = "push_time"
        case iterationCount = "iteration_count"
        case days, currentSeries
    }
}
