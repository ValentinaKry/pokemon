import SwiftUI

struct DetailPokemon: View {
    @StateObject var viewModel: DetailViewModel
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Image("Moon")
                    .resizable()
                    .ignoresSafeArea(.all)
            } else {
                Image("Bg")
                    .resizable()
                    .ignoresSafeArea(.all)
                Color.black.opacity(0.2)
                    .ignoresSafeArea(.all)
            }

            VStack {
                Spacer()
                VStack(alignment: .center) {
                    Text("Hello \n I'm \(viewModel.name.capitalized)")
                        .padding()
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text(viewModel.type)
                        .offset(y: 25)
                        .padding(.top, -20)
                    HStack {
                        VStack {
                            Text("\(viewModel.weight) kg")
                                .fontWeight(.bold)
                            Text("weight")
                        }
                        .padding(.horizontal)
                        Spacer()
                        VStack {
                            Text("\(viewModel.height) m")
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
                AsyncImage(url: viewModel.imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 250, height: 250)
                        .edgesIgnoringSafeArea(.top)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                        .scaleEffect(3)
                }
            }
        }
    }
}

struct DetailPokemon_Previews: PreviewProvider {
    @State static var url: URL? = nil
    static var previews: some View {
        DetailPokemon(
            viewModel: DetailViewModel(
                url: URL(string: "")!,
                pokemonManager: NetworkManager()))
    }
}

