//
//  GameDataSource.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation
import Alamofire

protocol GameDataSourceProtocol: AnyObject {

    func getGameList(page: String, result: @escaping (Result<[GameResponse], URLError>) -> Void)
    func getDetailGame(id: String, result: @escaping (Result<GameResponse, URLError>) -> Void)

}

final class GamesDataSource: NSObject {
    private override init() {}
    
    static let sharedInstance: GamesDataSource = GamesDataSource()
}

extension GamesDataSource: GameDataSourceProtocol {
    
    func getGameList(page: String, result: @escaping (Result<[GameResponse], URLError>) -> Void) {
        
        guard let url = URL(string: Endpoints.Gets.getGameList(page).url) else { return }
        
        AF.request(url).validate().responseDecodable(of: GameResponses.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value.results))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }

    func getDetailGame(id: String, result: @escaping (Result<GameResponse, URLError>) -> Void) {

        guard let url = URL(string: Endpoints.Gets.getGameDetail(id).url) else { return }

        AF.request(url).validate().responseDecodable(of: GameResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
}
