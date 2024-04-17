import Foundation

class PresentationErrorMapper {
    func map(error: DomainError?) -> String {
        guard error == .emptyResponse else {
            return "Characters list is empty. Try again later"
        }
        
        return "Something went wrong. Try again later"
    }
}
