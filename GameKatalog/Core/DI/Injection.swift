//
//  Injection.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    // provide gamelist
    private func provideRepository() -> GameRepositoryProtocol {
        let realm = try? Realm()
        let locale: GameListLocaleDataSource = GameListLocaleDataSource.sharedInstance(realm)
        let remote: GamesDataSource = GamesDataSource.sharedInstance
        return GameRepository.sharedInstance(locale, remote)
    }
    
    func provideGameList() -> GameListUseCase {
        let repository = provideRepository()
        return GameListInteractor(repository: repository)
    }
    
    func provideGameDetail(id: String) -> GameDetailUseCase {
        let repository = provideRepository()
        return GameDetailInteractor(repository: repository, id: id)
    }
}
