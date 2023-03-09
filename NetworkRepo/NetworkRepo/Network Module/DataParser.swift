//
//  DataParser.swift
//  NetworkRepo
//
//  Created by Abhishek Maurya on 01/03/23.
//

import Foundation

class DataParser<T: Decodable> {
    func parse(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
