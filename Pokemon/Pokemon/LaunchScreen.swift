
import SwiftUI

struct LaunchScreen: View {

    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State private var firstPhaseAnimation: Bool = false
    @State private var secondPhaseAnimation: Bool = false

    private let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            background
            logo
        }
        .onReceive(timer) { input in
            switch launchScreenManager.state {
            case .first :
                withAnimation(.spring()) {
                    firstPhaseAnimation.toggle()
                }
            case .second:
                withAnimation(.easeInOut) {
                    secondPhaseAnimation.toggle()
                }
            default: break

            }
        }
        .opacity(secondPhaseAnimation ? 0 : 1)
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
            .environmentObject(LaunchScreenManager())
    }
}

private extension LaunchScreen {
    var background: some View {
        Color("LaunchScreenColor")
            .edgesIgnoringSafeArea(.all)
    }

    var logo: some View {
        Image("pokemon-icon")
            .resizable()
            .frame(width: 200, height: 200)
            .scaleEffect(firstPhaseAnimation ? 0.6 : 1)
            .scaleEffect(secondPhaseAnimation ? UIScreen.main.bounds.size.height / 4 : 1)
    }
}
