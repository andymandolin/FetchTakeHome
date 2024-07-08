import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from the server."
        case .invalidData:
            return "The data received from the server is invalid."
        }
    }
}
