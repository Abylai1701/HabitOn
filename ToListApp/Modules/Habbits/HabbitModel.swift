import Foundation

struct HabbitModel: Codable {
    let id: Int
    let name, color, currentInterval, cratedAt: String
    let currentPeriodStart: Int
}
