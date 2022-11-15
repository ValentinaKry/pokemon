
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
            let front_default: String
        }
    }

    var pokemonType: String {
        return "Types: \(types.map{$0.type.name}.joined(separator: ", "))"
    }
    var pokemonImage: String {
        return sprites.home.front_default
    }
}
