//
//  GameListMapper.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

final class GameMapper {

    static func mapGameResponsesToDomains(input gameResponses: [GameResponse]) -> [GameModel] {

        return gameResponses.map { result in
            return GameModel(
                id: result.id ?? 0,
                slug: result.slug ?? "",
                name: result.name ?? "",
                released: result.released ?? "",
                backgroundImage: result.backgroundImage ?? "",
                rating: result.rating ?? 0.0,
                ratingTop: result.ratingTop ?? 0.0,
                genres: mapGenreResponsesToDomains(input: result.genres ?? []),
                nameOriginal: result.nameOriginal,
                description: result.description
            )
        }
    }

    static func mapGameResponsesToEntity(input gameResponses: [GameResponse]) -> [GameEntity] {
        return gameResponses.map { result in
            let newGame = GameEntity()
            newGame.id          = result.id ?? 0
            newGame.slug        = result.slug ?? ""
            newGame.name        = result.name ?? ""
            newGame.released    = result.released ?? ""
            newGame.backgroundImage = result.backgroundImage ?? ""
            newGame.rating      = result.rating ?? 0
            newGame.ratingTop   = result.ratingTop ?? 0
            for genre in result.genres ?? [] {
                let genreEntity = GenreGameEntity()
                genreEntity.id = genre.id ?? 0
                genreEntity.name = genre.name ?? ""
                newGame.genres.append(genreEntity)
            }
            return newGame
        }
    }

    static func mapGameEntitiesToDomains(input mapEntities: [GameEntity]) -> [GameModel] {

        return mapEntities.map { result in
            let genres = mapGenreEntitiesToDomains(
                input: Array(result.genres)
            )

            return GameModel(
                id: result.id ,
                slug: result.slug ,
                name: result.name ,
                released: result.released ,
                backgroundImage: result.backgroundImage ,
                rating: result.rating ,
                ratingTop: result.ratingTop,
                genres: genres,
                nameOriginal: result.nameOriginal,
                description: result.description
            )
        }
    }

    static func mapGenreEntitiesToDomains(input genreEntities: [GenreGameEntity]) -> [GameGenreModel] {
        return genreEntities.map { result in
            return GameGenreModel(
                id: result.id,
                name: result.name
            )
       }
    }

    static func mapGenreResponsesToDomains(input genreEntities: [GameGenreResponse]) -> [GameGenreModel] {
        return genreEntities.map { result in
            return GameGenreModel(
                id: result.id,
                name: result.name
            )
        }
    }

    static func mapGameResponseToDomain(input gameDetailReponse: GameResponse) -> GameModel {
          return GameModel(
              id: gameDetailReponse.id ?? 0,
              slug: gameDetailReponse.slug ?? "",
              name: gameDetailReponse.name ?? "",
              released: gameDetailReponse.released ?? "",
              backgroundImage: gameDetailReponse.backgroundImage ?? "",
              rating: gameDetailReponse.rating ?? 0.0,
              ratingTop: gameDetailReponse.ratingTop ?? 0.0,
              genres: mapGenreResponsesToDomains(input: gameDetailReponse.genres ?? []),
              nameOriginal: gameDetailReponse.nameOriginal ?? "",
              description: gameDetailReponse.description ?? ""
          )
    }

}

