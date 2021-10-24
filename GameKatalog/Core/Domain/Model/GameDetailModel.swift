//
//  GameDetailModel.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import Foundation

struct GameDetailModel: Equatable, Identifiable {
    
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
    
}
