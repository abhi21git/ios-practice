//
//  APICall.swift
//  NetworkRepo
//
//  Created by Simran Rout on 19/02/23.
//

import Foundation

protocol NetworkProtocol {
    func apiCall(requestData: RequestDataProtocol, responseDataType: MovieListModel.Type, _ completion: @escaping (Result<MovieListModel, NetworkError>) -> Void)
}


class NetworkClass: NetworkProtocol {
    static let manager: NetworkProtocol = NetworkClass()
    private init() {}
    func getUrlRequest(requestData: RequestDataProtocol) -> URLRequest? {
        guard let apiUrl = setUrlParams(url: requestData.apiUrlData.apiUrl, params: requestData.queryParams) else { return nil }
        var urlRequest = URLRequest(url: apiUrl)
        urlRequest.httpMethod = requestData.apiType.rawValue
        return urlRequest
    }
    
    func setUrlParams(url: String, params: [String: String]) -> URL? {
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "api_key", value: "314b902cc56238b2a9a202c8734e5d8c")]
        for (key,value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        guard var urlComps = URLComponents(string: url) else {
            return nil
        }
        urlComps.queryItems = queryItems
        let url = urlComps.url
        return url
    }
    
    func apiCall(requestData: RequestDataProtocol,
                 responseDataType: MovieListModel.Type,
                 _ completion: @escaping (Result<MovieListModel, NetworkError>) -> Void) {
        guard let urlRequest = getUrlRequest(requestData: requestData) else {
            completion(.failure(.invalidURLRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.other(error.localizedDescription)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(response)")
              return
            }
            print(response, data)
        }
        task.resume()
    }
}




