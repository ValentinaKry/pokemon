import SwiftUI

struct ContentView: View {
    @StateObject var vm = PokemonViewModel()
    private var arrayPokemon = ["Bulb"]
    @State var searchText = ""

    var body: some View {
        NavigationView{
            VStack {
                List {
                    ForEach(Array(vm.result.enumerated()), id: \.offset) { index, item in

                        NavigationLink {

                            DetailPokemon()
                        } label: {
                                // Text("\(index)")
                            Text(item.name.capitalizingFirstLetter())
                                .font(.title2)
                                .textInputAutocapitalization(.characters)
                        }
                        .onTapGesture {
                            vm.index = index
                            print(vm.index)
                        }
                    }
                }
                .navigationTitle("Pokemon")
                .toolbarBackground(Color("Bg"), for: .navigationBar)
                .listStyle(.plain)

                HStack {
                    Button {

                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .frame(width: 40, height: 40)
                    .background(Color("Bg"))
                    .clipShape(Circle())
                    .padding(.horizontal)
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")

                    }
                    .frame(width: 40, height: 40)
                    .background(Color("Bg"))
                    .clipShape(Circle())
                    .padding(.horizontal)
                }

                .fontWeight(.bold)
                .padding(.top, 5)

            }
        }
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

