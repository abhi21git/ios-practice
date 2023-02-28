//
//  RequestDataModel.swift
//  NetworkRepo
//
//  Created by Simran Rout on 23/02/23.
//

import Foundation

protocol RequestDataProtocol {
    var apiType: ApiType {get set}
    var apiUrlData: ApiURL {get set}
    var responseType: MovieListModel.Type {get set}
   // var header: [String: String] {get set}
    var queryParams: [String:String] {get set}
}

struct RequestDataModel: RequestDataProtocol {
    var apiUrlData: ApiURL
    var apiType: ApiType
    var responseType: MovieListModel.Type
   // var header: [String : String]
    var queryParams: [String : String]
}

