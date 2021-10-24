//
//  HomeView.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import SwiftUI

struct GameListView: View {
    
    @ObservedObject var presenter: GameListPresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingSate {
                VStack {
                    Text("Lagi Loading...")
                    ActivityIndicator()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(
                        self.presenter.gameList,
                        id: \.id
                    ) { game in
                        ZStack {
                            self.presenter.linkDetailGameBuilder(for: "\(game.id ?? 0)") {
                                GameRow(gameModel: game)
                                    .frame(height: 85, alignment: .leading)
                                    .cornerRadius(8)
                            }.buttonStyle(PlainButtonStyle())
                            
                        }.padding(4)
                    }
                }
                .background(Color.gray.opacity(0.3))
            }
        }.onAppear() {
            if self.presenter.gameList.count == 0 {
                self.presenter.getGameList(page: "1")
            }
        }.navigationBarTitle(
            Text("Game Recommended"),
            displayMode: .inline
        )
    }
}
