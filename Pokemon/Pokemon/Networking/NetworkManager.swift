import Foundation

protocol DataSourceManagerProtocol {
    func loadData<T: Codable>(page: Int, compitionHandler: @escaping (T) -> Void, errorHandler: @escaping (String) -> Void)
}

class NetworkManager: DataSourceManagerProtocol {
    
    func loadData<T: Codable>(page: Int, compitionHandler: @escaping (T) -> Void, errorHandler: @escaping (String) -> Void) {
        let offset = page * 20
        let urlString = "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=20"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
            error == nil,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error dowloading data.")
                return
            }

            guard let newPockemon = try? JSONDecoder().decode(T.self, from: data) else {
                errorHandler("Encoding error")
                return

            }
            DispatchQueue.main.async {
                compitionHandler(newPockemon)
            }
        }
        .resume()
    }
}
