//
//  GameDetailPresenter.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import SwiftUI

class GameDetailPresenter: ObservableObject {
    
    private let gameDetailUseCase: GameDetailUseCase
    private let id: String
    
    @Published var gameDetail: GameModel?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(gameDetailUseCase: GameDetailUseCase, id: String) {
        self.gameDetailUseCase = gameDetailUseCase
        self.id = id
    }
    
    func getGameDetail() {
        self.loadingState = true
        self.gameDetailUseCase.getDetailGame(id: self.id) { gameDetail in
            switch gameDetail {
            
            case .success(let gameDet):
                DispatchQueue.main.async {
                    self.gameDetail = gameDet
                    self.loadingState = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}
