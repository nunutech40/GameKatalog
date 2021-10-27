//
//  GameDetailInteractor.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import Foundation

protocol GameDetailUseCase {
    
    func getDetailGame(id: String, completion: @escaping (Result<GameModel, Error>) -> Void)
    
}

class GameDetailInteractor: GameDetailUseCase {
    
    private let repository: GameRepositoryProtocol
    private let id: String
    
    required init(repository: GameRepositoryProtocol, id: String) {
        self.repository = repository
        self.id = id
    }
    
    func getDetailGame(id: String, completion: @escaping (Result<GameModel, Error>) -> Void) {
        self.repository.getGameDetail(id: id) { gameDetail in
            completion(gameDetail)
        }
    }
}
