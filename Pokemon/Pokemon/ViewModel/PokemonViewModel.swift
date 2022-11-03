import Foundation
import SwiftUI

class PokemonViewModel: ObservableObject {

    @Published var pockemons: [PokemonResponse] = []
    @Published var result: [PokemonData] = []
    @Published var arrayURL: [String] = []
    @Published var index: Int = 0
    @Published var url: String = "https://pokeapi.co/api/v2/pokemon"
    @ObservedObject var networkManager = NetworkManager()

    init () {
        networkManager.loadData(url: url, compitionHandler: { [weak self] item in
            self?.pockemons.append(item)
            for item in self?.pockemons ?? [] {
                self?.result = item.results
            }
            for url in self?.result ?? [] {
                self?.arrayURL.append(url.url)
            }
        })
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

