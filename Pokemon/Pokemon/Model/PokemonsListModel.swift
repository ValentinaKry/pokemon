import Foundation

    // MARK: - PockmonModel
struct PokemonsListModel: Codable {
    struct PokemonModel: Codable, Hashable{
        let name: String
        let url: String
    }
    let count: Int
    let results: [PokemonModel]

}


struct PokemonViewModel {
    let name: String
    var url: URL?

    init(from model: PokemonsListModel.PokemonModel) {
        self.name = model.name
        if let url = URL(string: model.url) {
            self.url = url
        } else {
            self.url = nil
        }
    }
}
