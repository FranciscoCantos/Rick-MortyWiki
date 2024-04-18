import Foundation

struct PaginationInfo: Codable, Equatable {
    let count, pages: Int
    let next: String?
    let prev: String?
    
    var queryParams: [String: String] {
        var result: [String: String] = [:]
        
        if let nextPage = next,
           let urlComponents = URLComponents(string: nextPage),
           let pageValue = urlComponents.queryItems?.first(where: { $0.name == "page" })?.value {
            result["page"] = pageValue
        }
        return result
    }
}
