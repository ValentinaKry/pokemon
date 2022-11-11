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
