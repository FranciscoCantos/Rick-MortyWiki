import Foundation

enum DomainError: Error {
    case generic
    case tooManyRequest
    
    case emptyResponse
}
