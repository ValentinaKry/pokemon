import Foundation

enum NetworkError: Error, LocalizedError {
    case downloadError
    case decoding

    var errorDescription: String? {
        switch self {
        case .downloadError:
            return NSLocalizedString("Please check your networking📡❌. And try again 👍", comment: "")
        case .decoding:
            return NSLocalizedString("Could not load Pockemon list, please reinstall the app.", comment: "")
        }
    }
}

struct ErrorType: Identifiable {
    let id = UUID()
    let error: NetworkError
}
