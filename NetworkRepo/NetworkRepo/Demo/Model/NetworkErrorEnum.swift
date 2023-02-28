//
//  NetworkError.swift
//  NetworkRepo
//
//  Created by Simran Rout on 23/02/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURLRequest
    case dataParsingError
    case dataNotFound
    case other(String)
}
