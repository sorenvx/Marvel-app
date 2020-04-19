//
//  SuperheroData.swift
//  Marvel
//
//  Created by Toni De Gea on 16/04/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//



import Foundation

// MARK: - Welcome
struct MarvelAPI: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: Data
}

// MARK: - DataClass
struct Data: Codable {
    let offset, limit, total, count: Int?
    let results: [Result]

}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let description: String?
    let modified: Date?
    let thumbnail: Thumbnail
}


// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}
