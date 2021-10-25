//
//  NetworkManager.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 22.10.2021.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    func fetchData<T:Codable>(from url: URL, resultType: T.Type, complition: @escaping(Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complition(.failure(error))
            }
            if let data = data, let parsedJSON = self.parseJSON(data: data, responseType: resultType.self)  {
                complition(.success(parsedJSON))
            } else {
                complition(.failure(CustomErrors.wrongData))
            }
        }
        task.resume()
    }

    private func parseJSON<T: Codable>(data: Data, responseType: T.Type) -> T? {
        let decoder = JSONDecoder()
        if let json = try? decoder.decode(T.self, from: data) {
            return json
        }
        return nil
    }
}

enum CustomErrors: Error {
    case wrongData
    case serverEnable
    public var errorDescription: String? {
            switch self {
            case .wrongData:
                return "Wrong user data format"
            case .serverEnable:
                return "Github is not available right now"
            }
        }
}
