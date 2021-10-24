//
//  GameListRouter.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import SwiftUI

class GameListRouter {
    
    func makeDetailGameView(for id: String) -> some View {
        let gameDetailUseCase = Injection.init().provideGameDetail(id: id)
        let presenter = GameDetailPresenter(gameDetailUseCase: gameDetailUseCase, id: id)
        return GameDetailView(presenter: presenter)
    }
    
}
