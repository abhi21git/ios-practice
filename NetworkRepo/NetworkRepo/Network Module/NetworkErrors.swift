//
//  NetworkErros.swift
//  NetworkRepo
//
//  Created by Abhishek Maurya on 09/03/23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl(url: String)
    
    public var localizedDescription: String {
        switch self {
        case .invalidUrl(let url):
            return "URL: \(url) is invalid."
        }
    }
}
