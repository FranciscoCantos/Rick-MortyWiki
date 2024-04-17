import Foundation

enum CharacterGender: String, Codable {
    case female = "female"
    case male = "male"
    case genderless = "genderless"
    case unknown = "unknown"
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "female":
            self = .female
        case "male":
            self = .male
        case "genderless":
            self = .genderless
        default:
            self = .unknown
        }
    }
}
