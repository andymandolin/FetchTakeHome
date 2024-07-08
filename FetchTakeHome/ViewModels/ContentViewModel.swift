import Foundation

final class ContentViewModel: ObservableObject {
    let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol = Networking.shared) {
        self.networking = networking
    }
}
