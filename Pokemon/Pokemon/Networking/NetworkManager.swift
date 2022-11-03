import Foundation

class NetworkManager: ObservableObject {
    
    func loadData<T: Codable>(url: String, compitionHandler: @escaping (T) -> Void) {
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

            guard let newPockemon = try? JSONDecoder().decode(T.self, from: data) else {return}
            DispatchQueue.main.async {
                compitionHandler(newPockemon)
            }
        }
        .resume()
    }

}
