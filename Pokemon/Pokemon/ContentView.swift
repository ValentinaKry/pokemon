import SwiftUI

struct ContentView: View {
    @StateObject var vm = PokemonsListViewModel(networkManager: NetworkManager() )
    @EnvironmentObject var launchSreenManager: LaunchScreenManager

    var body: some View {
        NavigationView{
            VStack {
                List {
                    ForEach(Array(vm.result.enumerated()), id: \.offset) { index, item in
                        NavigationLink {

                            DetailPokemon(viewModel: DetailViewModel(url: item.url, pokemonManager: NetworkManager()))
                        } label: {
                            Text(item.name.capitalized)
                                .font(.title2)
                                .textInputAutocapitalization(.characters)
                        }
                    }
                }
                .navigationTitle("Pokemon")
                .toolbarBackground(Color("Bg"), for: .navigationBar)
                .listStyle(.plain)

                HStack {
                    Button {
                        vm.loadPreviousPokemonsPage()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .frame(width: 40, height: 40)
                    .background(Color("Bg"))
                    .clipShape(Circle())
                    .padding(.horizontal)
                    Button {
                        vm.loadNextPokemonsPage()
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
        .alert(item: $vm.appError) { appError in
            Alert(title: Text("Oh Oh"), message: Text(appError.error.localizedDescription))
        }
        .accentColor(.white)
        .onAppear {
            DispatchQueue
                .main
                .asyncAfter(deadline: .now() + 1.2) {
                    launchSreenManager.dismiss()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchScreenManager())
    }
}

