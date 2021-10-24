//
//  GameDetailRepository.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import Foundation

protocol GameDetailRepositoryProtocol {
    func getGameDetail(id: String, result: @escaping (Result<GameDetailModel, Error>) -> Void)
}

final class GameDetailRepository: NSObject {
    
    typealias GameDetailInstance = (GameDetailDataSource) -> GameDetailRepository
    
    fileprivate let remote: GameDetailDataSource
    
    private init(remote: GameDetailDataSource) {
        self.remote = remote
    }
    
    static let sharedInstace: GameDetailInstance = { gameDetail in
        return GameDetailRepository(remote: gameDetail)
    }
}

extension GameDetailRepository: GameDetailRepositoryProtocol {
    func getGameDetail(id: String, result: @escaping (Result<GameDetailModel, Error>) -> Void) {
        self.remote.getDetailGame(id: id) { gameDetail in
            switch gameDetail {
            case .success(let gameDetailResponse):
                let resultGameDetail = GameDetailMapper.mapGameDetailResponseToDomain(input: gameDetailResponse)
                result(.success(resultGameDetail))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
