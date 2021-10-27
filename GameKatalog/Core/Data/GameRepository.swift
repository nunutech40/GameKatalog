//
//  GameRepository.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

protocol GameRepositoryProtocol {
    
    func getGamesList(page: String, result: @escaping (Result<[GameModel], Error>) -> Void)
    func getGameDetail(id: String, result: @escaping (Result<GameModel, Error>) -> Void)
    
}

final class GameRepository: NSObject {
    
    typealias GameInstance = (GameListLocaleDataSource, GamesDataSource) -> GameRepository
    
    fileprivate let remote: GamesDataSource
    fileprivate let locale: GameListLocaleDataSource
    
    private init(locale: GameListLocaleDataSource, remote: GamesDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = { localRepo, remoteRepo in
        return GameRepository(locale: localRepo, remote: remoteRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    
    func getGamesList(page: String, result: @escaping (Result<[GameModel], Error>) -> Void) {
        locale.getGameList { localeResponse in
            switch localeResponse {
            case .success(let gameEntity):
                let gameList = GameMapper.mapGameEntitiesToDomains(input: gameEntity)
                if gameList.isEmpty {
                    self.remote.getGameList(page: page) { remoteResponse in
                        switch remoteResponse {
                        case .success(let gameResponses):
                            let gameEntities = GameMapper.mapGameResponsesToEntity(input: gameResponses)
                            self.locale.addCategories(from: gameEntities) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    if resultFromAdd {
                                        self.locale.getGameList { localeResponses in
                                            switch localeResponses {
                                            case .success(let gameEntity):
                                                let resultList = GameMapper.mapGameEntitiesToDomains(input: gameEntity)
                                                result(.success(resultList))
                                            case .failure(let error):
                                                result(.failure(error))
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    result(.failure(error))
                                }
                            }
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else {
                    result(.success(gameList))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }

    func getGameDetail(id: String, result: @escaping (Result<GameModel, Error>) -> Void) {
        // Di sini kita bisa update tambahan data berupa deskripsi dan original name ke dalam data local
      
        self.remote.getDetailGame(id: id) { gameDetail in
            switch gameDetail {
            case .success(let gameDetailResponse):
                let resultGameDetail = GameMapper.mapGameResponseToDomain(input: gameDetailResponse)
                result(.success(resultGameDetail))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
