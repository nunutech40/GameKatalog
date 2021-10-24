//
//  GameDetailDataSource.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import Foundation
import Alamofire

protocol GameDetailDataSourceProtocol: class {
    func getDetailGame(id: String, result: @escaping (Result<GameDetailResponse, URLError>) -> Void)
}

final class GameDetailDataSource: NSObject {
    
    private override init() {}
    
    static let sharedInstance: GameDetailDataSource = GameDetailDataSource()
}

extension GameDetailDataSource: GameDetailDataSourceProtocol {
    
    func getDetailGame(id: String, result: @escaping (Result<GameDetailResponse, URLError>) -> Void) {
        
        guard let url = URL(string: Endpoints.Gets.getGameDetail(id).url) else { return }
        
        AF.request(url).validate().responseDecodable(of: GameDetailResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
}
