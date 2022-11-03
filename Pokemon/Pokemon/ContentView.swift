import SwiftUI

struct ContentView: View {

    @StateObject var vm = PokemonViewModel()

    var body: some View {
        NavigationView{
            VStack {
                NavigationLink {
                    DetailPokemon()
                } label: {
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
                }
                .navigationTitle("Pokemon")

                HStack {
                    Button {

                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Button {
                        vm.getPosts()
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
              //  .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

