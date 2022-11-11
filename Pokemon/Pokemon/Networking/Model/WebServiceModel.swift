import Foundation

enum BaseURL: String {
    case authorization = "https://pokeapi.co/api/v2/pokemon?offset="
}
enum Path : String {
    case endPoint = "&limit=20"
}


//"https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=20"
