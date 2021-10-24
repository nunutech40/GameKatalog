//
//  GameListInteractor.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

protocol GameListUseCase {
    func getGameList(page: String, completion: @escaping (Result<[GameModel], Error>) -> Void)
}

class GameListInteractor: GameListUseCase {
    
    private let repository: GamesRepositoryProtocol
    
    required init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGameList(page: String, completion: @escaping (Result<[GameModel], Error>) -> Void) {
        repository.getGamesList(page: page) { gameList in
            completion(gameList)
        }
    }
    
}
