import Foundation
import SwiftUI

struct PokemonViewModel {
    let name: String
    let url: URL?

    init(from model: PokemonsListModel.PokemonModel) {
        self.name = model.name.capitalizingFirstLetter()
        if let url = URL(string: model.url) {
            self.url = url
        } else {
            self.url = nil
        }
    }
}

class PokemonsListViewModel: ObservableObject {

        @Published var result: [PokemonViewModel] = []
        var networkManager: DataSourceManagerProtocol
        var currentPage = 0

        init (networkManager: DataSourceManagerProtocol) {
            self.networkManager = networkManager
            loadPokemons()
        }

        private func loadPokemons() {
            networkManager.loadData(page: currentPage, compitionHandler: { [weak self] (item: PokemonsListModel) in
                self?.result = item.results.map { model in
                    PokemonViewModel(from: model)
                }
            }, errorHandler: { erroMessage in
                print(erroMessage)
            })
        }

        func loadNextPokemonsPage() {
            currentPage += 1
            loadPokemons()
        }

        func loadPreviousPokemonsPage() {
            guard currentPage > 0 else { return }
            currentPage -= 1
            loadPokemons()
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

