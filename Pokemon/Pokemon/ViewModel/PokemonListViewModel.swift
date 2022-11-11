import Foundation
import SwiftUI

struct PokemonViewModel {
    let name: String
    let url: URL?

    init(from model: PokemonsListModel.PokemonModel) {
        self.name = model.name
        if let url = URL(string: model.url) {
            self.url = url
        } else {
            self.url = nil
        }
    }
}

class PokemonsListViewModel: ObservableObject {

    @Published var result: [PokemonViewModel] = []
    @Published var appError: ErrorType? = nil
    var networkManager: DataSourceManagerProtocol
    var currentPage = 0

    init (networkManager: DataSourceManagerProtocol) {
        self.networkManager = networkManager
        loadPokemons()
    }

    private func loadPokemons() {
        networkManager.loadData(page: currentPage, compitionHandler: { [weak self] (item: PokemonsListModel) in self?.result = item.results.map { model in
                PokemonViewModel(from: model)
            }
        }, errorHandler: { errorMessage in
            self.appError = ErrorType(error: .downloadError)
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

