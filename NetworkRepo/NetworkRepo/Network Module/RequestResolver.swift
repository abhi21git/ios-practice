//
//  RequestResolver.swift
//  NetworkRepo
//
//  Created by Abhishek Maurya on 01/03/23.
//

import Foundation

class RequestResolver {
    func getRequest(for urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
    
    func request<T: Decodable>(for url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = getRequest(for: url) else {
            completion(.failure(NetworkError.invalidUrl(url: url)))
            return
        }
        let network = NetworkResolver<T>()
        network.request(for: request) { result in
            switch result {
            case .success(let rawData):
                do {
                    let parser = DataParser<T>()
                    let data = try parser.parse(rawData)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
