import Foundation

enum CharacterStatus: String, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
    
    init?(rawValue: String) {
        switch rawValue {
        case "Alive":
            self = .alive
        case "Dead":
            self = .dead
        default:
            self = .unknown
        }
    }
}
