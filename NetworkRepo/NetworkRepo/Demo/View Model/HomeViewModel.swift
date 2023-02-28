//
//  HomeViewModel.swift
//  NetworkRepo
//
//  Created by Simran Rout on 26/02/23.
//

import Foundation
class HomeViewModel {
    var apiCall = NetworkClass.manager
    
    func getMovieList() {
        apiCall.apiCall(requestData: RequestDataModel(apiUrlData: .getMovieList, apiType: .get, responseType: MovieListModel.self, queryParams: ["language":"en-US", "page":"1"]),
                        responseDataType: MovieListModel.self) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
}
