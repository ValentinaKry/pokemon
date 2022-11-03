import Foundation
import SwiftUI

class PokemonViewModel: ObservableObject {

    @Published var pockemons: [PokemonResponse] = []
    @Published var result: [PokemonData] = []
    @Published var url: String = "https://pokeapi.co/api/v2/pokemon"

    init () {
        getPosts()
    }

    func getPosts() {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("No data")
                return
            }
            guard error == nil else{
                print("Error: \(String(describing: error))")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                print("Invalid response.")
                return
            }

            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code should be 2xx, but  is \(response.statusCode)")
                return
            }

            print("SUCCESSFULLY DOWNLOADED DATA!")
            print(data)
            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString!)

            guard let newPockemon = try? JSONDecoder().decode(PokemonResponse.self, from: data) else {return}
            DispatchQueue.main.async { [weak self] in
                self?.pockemons.insert(newPockemon, at: 0)
                if self?.pockemons.count ?? 0 > 1 {
                    self?.pockemons.removeLast()
                }
                self?.url = self?.pockemons.first?.next ?? ""
                for item in self?.pockemons ?? [] {
                    self?.result = item.results
                }
            }
        }
        .resume()
    }
    
}
