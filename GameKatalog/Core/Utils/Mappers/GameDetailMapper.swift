//
//  GameDetailMapper.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import Foundation

final class GameDetailMapper {
    
    static func mapGameDetailResponseToDomain(input gameDetailReponse: GameDetailResponse) -> GameDetailModel {
        return GameDetailModel(
            id: gameDetailReponse.id ?? 0,
            slug: gameDetailReponse.slug ?? "",
            name: gameDetailReponse.name ?? "",
            nameOriginal: gameDetailReponse.nameOriginal ?? "",
            description: gameDetailReponse.description ?? "",
            rating: gameDetailReponse.rating ?? 0.0,
            ratingTop: gameDetailReponse.ratingTop ?? 0.0,
            released: gameDetailReponse.released,
            backgroundImage: gameDetailReponse.backgroundImage ?? "",
            genres: gameDetailReponse.genres ?? [])
    }
    
}
