import Foundation

    // MARK: - PockmonModel
struct PokemonsListModel: Codable {
    struct PokemonModel: Codable, Hashable{
        let name: String
        let url: URL
    }
    let count: Int
    let results: [PokemonModel]

}

struct PokemonPresentationModel {
    let name: String
    var url: URL

    init(from model: PokemonsListModel.PokemonModel) {
        self.name = model.name
        self.url = model.url
    }
}
