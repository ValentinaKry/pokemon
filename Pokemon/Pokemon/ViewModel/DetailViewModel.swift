import Foundation
import SwiftUI
import Combine

final class DetailViewModel: ObservableObject {

    @Published var name: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var type: String = ""
    @Published var imageURL: URL?

    private let pokemonDetail = CurrentValueSubject<DetailModel?, ErrorType>(nil)

    @Published var url: URL
    @Published var isLoading = false
    @Published var appError: ErrorType? = nil

    private var pokemonManager : DataSourceManagerProtocol
    private var cancellables = Set<AnyCancellable>()

    init(
        url: URL,
        isLoading: Bool = false,
        pokemonManager: DataSourceManagerProtocol
    ) {
        self.url = url
        self.isLoading = isLoading
        self.pokemonManager = pokemonManager
        getDetails()
        setupBindings()
    }
}

private extension DetailViewModel {
    func getDetails() {
        pokemonManager.getDetailedPokemon(
            url: url
        ) { [weak self] (item: DetailModel) in
            self?.pokemonDetail.send(item)
        } errorHandler: { errorMessage in
            self.pokemonDetail.send(completion: .failure(ErrorType(error: .downloadError)))
        }
    }

    func setupBindings() {
        pokemonDetail
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.appError = error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] pokemonDetail in
                guard let self = self,
                      let detail = pokemonDetail else { return }
                self.name = detail.name
                self.height = self.formatHW(value: detail.height)
                self.weight = self.formatHW(value: detail.weight)
                self.imageURL = detail.pokemonImage
                self.type = detail.pokemonType
            }
            .store(in: &cancellables)
    }

    func formatHW(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 10)

        return string
    }
}
