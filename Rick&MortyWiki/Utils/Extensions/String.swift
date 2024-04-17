import Foundation

extension String {
    func formattedDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter.date(from: self)
    }
}
