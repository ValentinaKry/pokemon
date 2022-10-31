import Foundation

class Api {
    func getPost(completion: @escaping ([PockemonResponse]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
            print("hey man THIS URL DOES NOT WORK")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                let dataString = String(data: safeData, encoding: .utf8)
                print(dataString!)
            }

            let posts = try! JSONDecoder().decode([PockemonResponse].self, from: data!)
            DispatchQueue.main.async {
                completion(posts)
                print("I.m here")
            }
        }
        .resume()
    }
}
