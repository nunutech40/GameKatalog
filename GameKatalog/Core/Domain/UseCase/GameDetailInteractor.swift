//
//  GameDetailInteractor.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import Foundation

protocol GameDetailUseCase {
    
    func getDetailGame(id: String, completion: @escaping (Result<GameDetailModel, Error>) -> Void)
    
}

class GameDetailInteractor: GameDetailUseCase {
    
    private let repository: GameDetailRepositoryProtocol
    private let id: String
    
    required init(repository: GameDetailRepositoryProtocol, id: String) {
        self.repository = repository
        self.id = id
    }
    
    func getDetailGame(id: String, completion: @escaping (Result<GameDetailModel, Error>) -> Void) {
        self.repository.getGameDetail(id: id) { gameDetail in
            completion(gameDetail)
        }
    }
}
