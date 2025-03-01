//
//  LPViewModel.swift
//  PracticeProject
//
//  Created by Abhishek Maurya on 01/03/25.
//

import Foundation

public final class LPViewModel: ObservableObject {
    @Published public private(set) var data: [LPModel] = []
    
    public init() {
        
    }
    
    public func loadData() {
        Task {
            guard let url = URL(string: LPModel.url) else { return }
            let request = URLRequest(url: url)
            do {
                let response: (data: Data, response: URLResponse) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                let data = try decoder.decode([LPModel].self, from: response.data)
                Task { @MainActor [weak self] in
                    self?.data = data
                }
            } catch {
                debugPrint(error)
            }
        }
    }
}
