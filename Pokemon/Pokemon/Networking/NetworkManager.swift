import Foundation

protocol DataSourceManagerProtocol {
    func loadData<T: Codable>(page: Int, completionHandler: @escaping (T) -> Void, errorHandler: @escaping (NetworkError) -> Void)
    func getDetailedPokemon<T: Codable>(url: URL? , _ completionHandler: @escaping (T) -> Void, errorHandler: @escaping (NetworkError) -> Void)
}

class NetworkManager: DataSourceManagerProtocol {

    func loadData<T: Codable>(page: Int, completionHandler: @escaping (T) -> Void, errorHandler: @escaping (NetworkError) -> Void) {
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
                completionHandler(newPockemon)
            }
        }
        .resume()
    }

    func getDetailedPokemon<T: Codable>(url: URL?, _ completionHandler: @escaping (T) -> Void, errorHandler: @escaping (NetworkError) -> Void) {
        guard let detailURL = url else {return}
        URLSession.shared.dataTask(with: detailURL) { (data, response, error) in
            guard let data = data,
            error == nil,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                errorHandler(.downloadError)
                return
            }

            guard let detailPockemon = try? JSONDecoder().decode(T.self, from: data) else {
                errorHandler(.decoding)
                return

            }
            DispatchQueue.main.async {
                completionHandler(detailPockemon)
            }
        }
        .resume()
    }
}
