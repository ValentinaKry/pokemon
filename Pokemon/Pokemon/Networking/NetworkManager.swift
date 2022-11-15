import Foundation

protocol DataSourceManagerProtocol {
    func loadData<T: Codable>(page: Int, completionHandler: @escaping (T) -> Void, errorHandler: @escaping (NetworkError) -> Void)
    func getDetailedPokemon<T: Codable>(url: URL? , _ completionHandler: @escaping (T) -> Void, errorHandler: @escaping (NetworkError) -> Void)
}

final class NetworkManager: DataSourceManagerProtocol {

    private let session: URLSession

    init(_ session: URLSession = .shared) {
        self.session = session
    }

    func loadData<T: Codable>(
        page: Int,
        completionHandler: @escaping (T) -> Void,
        errorHandler: @escaping (NetworkError) -> Void
    ) {
        let offset = page * 20
        let baseURL =  BaseURL.authorization.rawValue
        guard let url = URL(string: baseURL + String(offset) + Path.endPoint.rawValue) else {
            errorHandler(.badRequest)
            return
        }

        request(url: url) { (result: Result<T, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let success):
                        completionHandler(success)
                    case .failure(let failure):
                        errorHandler(failure)
                }
            }
        }
    }

    func getDetailedPokemon<T: Codable>(
        url: URL?,
        _ completionHandler: @escaping (T) -> Void,
        errorHandler: @escaping (NetworkError) -> Void
    ) {
        guard let detailURL = url else {return}
        request(url: detailURL) { (result: Result<T, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let success):
                        completionHandler(success)
                    case .failure(let failure):
                        errorHandler(failure)
                }
            }
        }
    }

    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.downloadError(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.downloadError(nil)))
                return
            }
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 && response.statusCode >= 300 {
                completion(.failure(.downloadError(nil)))
                return
            }
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.decoding))
                return
            }
            completion(.success(result))
        }.resume()
    }
}
