//
//  GameListEntity.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var slug: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var ratingTop: Double = 0.0
    @objc dynamic var nameOriginal: String = ""
    @objc dynamic var desc: String = ""
    var genres = List<GenreGameEntity>()
    
    override static func primaryKey() -> String {
        return "id"
    }
}

class GenreGameEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}

