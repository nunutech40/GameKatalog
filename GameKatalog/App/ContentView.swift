//
//  ContentView.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var gameListPresenter: GameListPresenter
    
    var body: some View {
        NavigationView {
            GameListView(presenter: gameListPresenter)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
