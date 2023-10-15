import Foundation

struct GoalDetailModel: Codable {
    let name: String?
    let days: [String]?
    let iterationCount: Int?
    let pushTime: String?
    let done: Bool
    let totalQty, longestSeries, currentSeries: Int?
    let history: [History]?

    enum CodingKeys: String, CodingKey {
        case name, days
        case iterationCount = "iteration_count"
        case pushTime = "push_time"
        case done, totalQty, longestSeries, currentSeries
        case history
    }
}

// MARK: - History
struct History: Codable {
    let done: Bool
    let date, dayOfWeek: String
    let unixTime: Int

    enum CodingKeys: String, CodingKey {
        case done, date, dayOfWeek
        case unixTime = "unix_time"
    }
}
