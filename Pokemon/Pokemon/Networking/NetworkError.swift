import Foundation

enum NetworkError: Error, LocalizedError {
    case downloadError(Error?)
    case decoding
    case badRequest
    var errorDescription: String? {
        switch self {
        case .downloadError:
            return NSLocalizedString("Please check your networking📡❌. And try again 👍", comment: "")
        case .decoding:
            return NSLocalizedString("Could not load Pockemon list, please reinstall the app.", comment: "")
        case .badRequest:
            return "404 error. /nProblem with your request. /nDownload your app, please."
        }
    }
}

struct ErrorType: Error, Identifiable {
    let id = UUID()
    let error: NetworkError
}


