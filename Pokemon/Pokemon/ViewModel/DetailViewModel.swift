import Foundation
import SwiftUI

class DetailViewModel: ObservableObject {

    @Published var pokemonDetail: DetailModel?
    @Published var pokemonList = [PokemonsListModel]()
    
    var pokemonManager = NetworkManager()

  
}
