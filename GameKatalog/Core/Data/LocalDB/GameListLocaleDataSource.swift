//
//  GameListLocaleDataSource.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import Foundation
import RealmSwift

protocol GameListLocalDataSourceProtocol: class {
    
    func getGameList(result: @escaping (Result<[GameEntity], DatabaseError>) -> Void)
    func addCategories(
        from gameList: [GameEntity],
        result: @escaping (Result<Bool, DatabaseError>) -> Void)
}

final class GameListLocaleDataSource: NSObject {
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> GameListLocaleDataSource = { realmDatabase in
        return GameListLocaleDataSource(realm: realmDatabase)
    }
}

extension GameListLocaleDataSource: GameListLocalDataSourceProtocol {
    
    func getGameList(result: @escaping (Result<[GameEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            let games: Results<GameEntity> = {
                realm.objects(GameEntity.self)
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            result(.success(games.toArray(ofType: GameEntity.self)))
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    func addCategories(from gameList: [GameEntity], result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    for game in gameList {
                        realm.add(game, update: .all)
                    }
                    result(.success(true))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
      var array = [T]()
      for index in 0 ..< count {
        if let result = self[index] as? T {
          array.append(result)
        }
      }
      return array
    }
}
