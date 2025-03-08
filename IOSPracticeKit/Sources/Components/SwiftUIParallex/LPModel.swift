//
//  LPModel.swift
//  PracticeProject
//
//  Created by Abhishek Maurya on 01/03/25.
//

public struct LPModel: Decodable, Identifiable {
    public let id: String
    public let author: String
    public let imageURL: String
    public let pageURL: String
    public let width: Int
    public let height: Int
    
    public var aspectRatio: Double {
        Double(width) / Double(height)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height
        case imageURL = "download_url"
        case pageURL = "url"
    }
    
    static let url: String = "https://picsum.photos/v2/list"
}
