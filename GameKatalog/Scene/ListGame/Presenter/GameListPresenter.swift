//
//  GameListPresenter.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import SwiftUI

class GameListPresenter: ObservableObject {
    
    private let gameListUseCase: GameListUseCase
    private let router = GameListRouter()
    
    @Published var gameList: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingSate: Bool = false
    
    init(gameListUseCase: GameListUseCase) {
        self.gameListUseCase = gameListUseCase
    }
    
    func getGameList(page: String) {
        self.loadingSate = true
        self.gameListUseCase.getGameList(page: page) { game in
            switch game {
            case .success(let games):
                DispatchQueue.main.async {
                    self.loadingSate = false
                    self.gameList = games
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingSate = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}

extension GameListPresenter {
    
    func linkDetailGameBuilder<Content: View>(for id: String, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: router.makeDetailGameView(for: id)) {
            content()
        }
    }
    
}
