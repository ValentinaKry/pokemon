
import Foundation

struct DetailModel: Codable {
    let name : String
    let sprites : [Other]
    let height : Int
    let weight : Int
    let types : [Types]
}

struct Other: Codable {
    let home: [Front]

}

//MARK: Pokemon's image
struct Front: Codable {
    let front_default: String
}

//MARK: Pockemon's type
struct Types: Codable {
    let type: Name
}

struct Name: Codable {
    let name: String
}


//sprites.other.dream_world.front_default
