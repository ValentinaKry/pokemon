import SwiftUI

@main
struct PokemonApp: App {
    @StateObject var launchScreenManager = LaunchScreenManager()
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()

                if launchScreenManager.state != .completed {
                    LaunchScreen()
                }
            }
            .environmentObject(launchScreenManager)
        }
    }
}
