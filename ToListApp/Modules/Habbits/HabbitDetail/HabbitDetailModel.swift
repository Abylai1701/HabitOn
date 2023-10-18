import Foundation

// MARK: - Habbit
struct HabbitDetailModel: Codable {
    let id: Int
    let name, currentPeriod: String
    let color: ColorsType?
    let currentPeriodStart: Int
    let maxPeriod: String
    let periods: [Period]?
    let cratedAt: String
}

// MARK: - Period
struct Period: Codable {
    let interval, start: String
    let startUnix: Int

    enum CodingKeys: String, CodingKey {
        case interval, start
        case startUnix = "start_unix"
    }
}


// MARK: - Message
struct MessageModel: Codable {
    let message: String
}
