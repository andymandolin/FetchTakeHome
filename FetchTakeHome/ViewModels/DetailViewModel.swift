import Foundation

final class DetailViewModel: ObservableObject {
    let networking: NetworkingProtocol

    init(networking: NetworkingProtocol = Networking.shared) {
        self.networking = networking
    }
}
    
