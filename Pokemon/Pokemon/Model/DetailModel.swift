
import Foundation

struct DetailModel: Codable, Identifiable {
    var id = UUID()
    let name : String
    let sprites : Other
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

    struct Other: Codable {
        let home: Front
            //MARK: Pokemon's image
        struct Front: Codable {
            let frontDefault: URL

            enum CodingKeys: String, CodingKey {
                case frontDefault = "front_default"
            }
        }
    }

    var pokemonType: String {
        return "Types: \(types.map{$0.type.name}.joined(separator: ", "))"
    }
    var pokemonImage: URL {
        return sprites.home.frontDefault
    }
}
