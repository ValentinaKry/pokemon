import SwiftUI

struct DetailPokemon: View {
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        ZStack {
            Image("Bg")
                .resizable()
                .ignoresSafeArea(.all)
            Color.black.opacity(0.2)
                .ignoresSafeArea(.all)
            VStack {
                Spacer()
                VStack(alignment: .center) {
                    Text("Hello \n I'm \(viewModel.pokemonDetail?.name ?? "")")
                        .padding()
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text(viewModel.pokemonDetail?.pokemonType ?? "")
                        .offset(y: 25)
                        .padding(.top, -20)
                    HStack {
                        VStack {
                            Text("\(viewModel.formatHW(value: viewModel.pokemonDetail?.weight ?? 0)) kg")
                                .fontWeight(.bold)
                            Text("weight")
                        }
                        .padding(.horizontal)
                        Spacer()
                        VStack {
                            Text("\(viewModel.formatHW(value: viewModel.pokemonDetail?.height ?? 0)) m")
                                .fontWeight(.bold)
                            Text("height")
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                }
                .background(Color("Bg"))
                .cornerRadius(40)
                .offset(y: -8)
                .padding()
                .shadow(radius: 5)
                Spacer()
                Image("1")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .edgesIgnoringSafeArea(.top)
            }

//            if isLoading {
//                LoadingView()
//            }
        }
//        .onAppear {
//            startFakeNetworkCall()
//
//        }
    }

//    func startFakeNetworkCall() {
//        isLoading = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
//            isLoading = false
//        }
//    }
}

struct DetailPokemon_Previews: PreviewProvider {
    @State static var url: URL? = nil
    static var previews: some View {
        DetailPokemon(viewModel: DetailViewModel(pokemonManager: NetworkManager()))
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Image("Bg")
                .resizable()
                .ignoresSafeArea(.all)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                .scaleEffect(3)
        }
    }
}
