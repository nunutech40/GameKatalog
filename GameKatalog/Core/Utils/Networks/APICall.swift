//
//  APICall.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

struct API {
    
    static let BaseURL = "https://api.rawg.io/api/games"
    static let key = "dde5e8d50a7b45c39e751473a338180a"
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        
        case getGameList(String)
        case search(String, String)
        case getTwoFav(Int)
        case getGameDetail(String)
        
        public var url: String {
            switch self {
            case .getGameList(let page):
                return API.BaseURL + "?key=\(API.key)&page=\(page)&page_size=100"
            case .search(let page, let query):
                return API.BaseURL + "?key=\(API.key)&page=\(page)&page_size=10&search=\(query.replacingOccurrences(of: " ", with: "%20"))"
            case .getTwoFav(let page):
                return API.BaseURL + "?key=\(API.key)&page=\(page)&page_size=10"
            case .getGameDetail(let idGame):
                return API.BaseURL + "/\(idGame)?key=\(API.key)"
            }
        
        }
    }
    
}
