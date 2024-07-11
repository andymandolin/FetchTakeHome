import SwiftUI
import SwiftData

@main
struct FetchTakeHomeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FavoriteDessertIds.self)
    }
}
