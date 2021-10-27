//
//  GameResponse.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

struct GameResponses: Decodable {
    let results: [GameResponse]
}

struct GameResponse: Decodable {
    
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Double?
    let genres: [GameGenreResponse]?
    let nameOriginal: String?
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
        case released = "released"
        case backgroundImage = "background_image"
        case rating = "rating"
        case ratingTop = "rating_top"
        case genres = "genres"
        case nameOriginal = "name_original"
        case description = "description_raw"
    }
}

struct GameGenreResponse: Decodable, Equatable, Identifiable {
    let id: Int?
    let name: String?
}
