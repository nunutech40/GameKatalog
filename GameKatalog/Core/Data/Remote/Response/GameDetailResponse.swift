//
//  GameDetailResponse.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import Foundation

struct GameDetailResponse: Decodable {
    
    let id: Int?
    let slug: String?
    let name: String?
    let nameOriginal: String?
    let description: String?
    let rating: Double?
    let ratingTop: Double?
    let released: String?
    let backgroundImage: String?
    let genres: [GameGenre]?
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
        case nameOriginal = "name_original"
        case description = "description_raw"
        case rating = "rating"
        case ratingTop = "rating_top"
        case released = "released"
        case backgroundImage = "background_image"
        case genres = "genres"
    }
}
