import Foundation

struct DetailModel: Codable {
    let name : String
    let sprites : Front
    let height : Int
    let weight : Int
    let types : [Types]

        //MARK: Pockemon's type
    struct Types: Codable {
        let type: Name
        struct Name: Codable {
            let name: String
        }
    }

    //MARK: Pokemon's image
    struct Front: Codable {
        let frontDefault: URL

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    var pokemonType: String {
        "Types: \(types.map{$0.type.name}.joined(separator: ", "))"
    }
    var pokemonImage: URL {
        sprites.frontDefault
    }
}
