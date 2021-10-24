//
//  GameRepository.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

protocol GamesRepositoryProtocol {
    
    func getGamesList(page: String, result: @escaping (Result<[GameModel], Error>) -> Void)
    
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

extension GameRepository: GamesRepositoryProtocol {
    
    func getGamesList(page: String, result: @escaping (Result<[GameModel], Error>) -> Void) {
        locale.getGameList { localeResponse in
            switch localeResponse {
            case .success(let gameEntity):
                let gameList = GameListMapper.mapGameEntitiesToDomains(input: gameEntity)
                if gameList.isEmpty {
                    self.remote.getGameList(page: page) { remoteResponse in
                        switch remoteResponse {
                        case .success(let gameResponses):
                            let gameEntities = GameListMapper.mapGameResponsesToEntity(input: gameResponses)
                            self.locale.addCategories(from: gameEntities) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    if resultFromAdd {
                                        self.locale.getGameList { localeResponses in
                                            switch localeResponses {
                                            case .success(let gameEntity):
                                                let resultList = GameListMapper.mapGameEntitiesToDomains(input: gameEntity)
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
    
}
