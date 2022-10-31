import Foundation

class PockemonViewModel: ObservableObject {

    @Published var pockemons: [PockemonResponse] = []
    @Published var result: [PockemonData] = []

    init () {
        getPosts()
    }

    func getPosts() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }

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

            guard let newPockemon = try? JSONDecoder().decode(PockemonResponse.self, from: data) else {return}
            DispatchQueue.main.async { [weak self] in
                self?.pockemons.append(newPockemon)

                for item in self?.pockemons ?? [] {
                    self?.result = item.results
                }
            }
        }
        .resume()
    }
    
}
