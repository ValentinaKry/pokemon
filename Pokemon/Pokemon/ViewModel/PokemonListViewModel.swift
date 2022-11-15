import Foundation
import SwiftUI

class PokemonsListViewModel: ObservableObject {

    @Published var result: [PokemonPresentationModel] = []
    @Published var appError: ErrorType? = nil
    var networkManager: DataSourceManagerProtocol
    var currentPage = 0

    init (networkManager: DataSourceManagerProtocol) {
        self.networkManager = networkManager
        loadPokemons()
    }

    private func loadPokemons() {
        networkManager.loadData(
            page: currentPage,
            completionHandler: { [weak self] (item: PokemonsListModel) in self?.result = item.results.map { model in
                PokemonPresentationModel(from: model)
            }
            }, errorHandler: { errorMessage in
                self.appError = ErrorType(error: .downloadError)
            }
        )
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
