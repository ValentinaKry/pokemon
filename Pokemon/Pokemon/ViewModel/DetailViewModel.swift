import Foundation
import SwiftUI

class DetailViewModel: ObservableObject {
    internal init(pokemonDetail: DetailModel? = nil, url: URL? = nil, isLoading: Bool = false, pokemonManager: DataSourceManagerProtocol) {
        self.pokemonDetail = pokemonDetail
        self.url = url
        self.isLoading = isLoading
        self.pokemonManager = pokemonManager
        getDetails()
    }

    @Published var pokemonDetail: DetailModel?
    @Published var url: URL?
    @Published var isLoading = false
    @Published var appError: ErrorType? = nil

    var pokemonManager : DataSourceManagerProtocol

    private func getDetails() {
        pokemonManager.getDetailedPokemon(url: url) { [weak self] (item: DetailModel) in
            self?.pokemonDetail = item
        } errorHandler: { errorMessage in
            self.appError = ErrorType(error: .downloadError)
        }
    }

    func formatHW(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 10)

        return string
    }
}
