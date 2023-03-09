//
//  APICall.swift
//  NetworkResolver
//
//  Created by Simran Rout on 19/02/23.
//

import Foundation

class NetworkResolver<T: Decodable> {
    func request(for request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                print(T.self)
                completion(.success(data))
            }
        }
    }
}
