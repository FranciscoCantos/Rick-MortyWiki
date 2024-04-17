import Foundation

enum CharacterStatus: String, Codable {
    case alive = "alive"
    case dead = "dead"
    case unknown = "Unknown"
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "alive":
            self = .alive
        case "dead":
            self = .dead
        default:
            self = .unknown
        }
    }
}
