//
//  GameModel.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Double?
    let genres: [GameGenre]?
}
