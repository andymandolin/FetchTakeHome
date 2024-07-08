import Foundation

protocol NetworkingProtocol {
}

class Networking: NetworkingProtocol {

    static let shared = Networking()
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}
