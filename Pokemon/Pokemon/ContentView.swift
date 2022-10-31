import SwiftUI

struct ContentView: View {

    @StateObject var vm = PockemonViewModel()

    var body: some View {
        NavigationView{
            List {
                ForEach(vm.result, id: \.self) { item in
                    VStack {
                        // Make Capitalization!
                        Text(item.name)
                            .font(.title2)
                            .textInputAutocapitalization(.characters)
                    }
                }
            }
            .navigationTitle("Pockemon")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

