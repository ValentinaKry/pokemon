import SwiftUI

struct DetailPokemon: View {

   // @StateObject var vm = PokemonViewModel()

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
                    Text("Hello \n I'm Bulbasaur")
                        .padding()
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("Types")
                        .offset(y: 25)
                        .padding(.top, -20)
                    HStack {
                        VStack {
                            Text("8.44 kg")
                                .fontWeight(.bold)
                            Text("weight")
                        }
                        .padding(.horizontal)
                        Spacer()
                        VStack {
                            Text("0.33 m")
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

        }
    }
}

struct DetailPokemon_Previews: PreviewProvider {
    static var previews: some View {
        DetailPokemon()
    }
}
