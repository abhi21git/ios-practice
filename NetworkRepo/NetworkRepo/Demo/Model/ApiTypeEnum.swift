//
//  ApiType.swift
//  NetworkRepo
//
//  Created by Simran Rout on 23/02/23.
//

import Foundation

public enum ApiType: String {
    case delete = "DELETE"
    case put = "PUT"
    case get = "GET"
    case post = "POST"
}

public enum ApiURL {
    case getMovieList
    private var apiKey: String {
        return "314b902cc56238b2a9a202c8734e5d8c"
    }
    
    private var apiQueryParam: String {
        return "api_key=\(apiKey)"
    }
    
    var apiUrl: String {
        switch self {
        case .getMovieList:
            return "https://api.themoviedb.org/3/movie/top_rated?\(apiQueryParam)"
        }
    }
}
