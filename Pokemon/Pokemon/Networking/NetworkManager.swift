import Foundation

protocol DataSourceManagerProtocol {
    func loadData<T: Codable>(page: Int, compitionHandler: @escaping (T) -> Void, errorHandler: @escaping (NetworkError) -> Void)
}

class NetworkManager: DataSourceManagerProtocol {

    func loadData<T: Codable>(page: Int, compitionHandler: @escaping (T) -> Void, errorHandler: @escaping (NetworkError) -> Void) {
        let offset = page * 20
        let baseURL =  BaseURL.authorization.rawValue
        guard let url = URL(string: baseURL + String(offset) + Path.endPoint.rawValue) else {
            errorHandler(.badRequest)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
            error == nil,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                errorHandler(.downloadError)
                return
            }

            guard let newPockemon = try? JSONDecoder().decode(T.self, from: data) else {
                errorHandler(.decoding)
                return

            }
            DispatchQueue.main.async {
                compitionHandler(newPockemon)
            }
        }
        .resume()
    }

//    func getDetailedPokemon(id: Int, _ completion:@escaping (DetailModel) -> ()) {
//        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: DetailModel.self) { data in
//            completion(data)
//            print(data)
//
//        } failure: { error in
//            print(error)
//        }
//    }
}
