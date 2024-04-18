import Foundation

struct PaginationInfo: Codable, Equatable {
    let count, pages: Int
    let next: String
    let prev: String?
    
    var queryParams: [String: String] {
        var result: [String: String] = [:]

        if let urlComponents = URLComponents(string: next),
           let pageValue = urlComponents.queryItems?.first(where: { $0.name == "page" })?.value {
            result["page"] = pageValue
        }
        return result
    }
}
