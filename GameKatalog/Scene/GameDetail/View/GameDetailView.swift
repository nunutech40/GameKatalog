//
//  GameDetailView.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetailView: View {
    
    @ObservedObject var presenter: GameDetailPresenter
    
    var body: some View {
        ZStack {
            if self.presenter.loadingState {
                VStack {
                    Text("Lagi Loading...")
                    ActivityIndicator()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollView(.vertical) {
                        VStack {
                            imageGame
                            spacer
                            content
                        }.padding()
                    }
                }
                .background(Color.gray.opacity(0.3))
            }
        }.onAppear {
            if self.presenter.gameDetail == nil {
                self.presenter.getGameDetail()
            }
        }.navigationBarTitle(
            Text("Game Detail"),
            displayMode: .inline
        )
        
        ZStack {
            
        }
    }
}

extension GameDetailView {
    
    var imageGame: some View {
        WebImage(url: URL(string: self.presenter.gameDetail?.backgroundImage ?? ""))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: 250, height: 250, alignment: .center)
    }
    
    var spacer: some View {
        Spacer()
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title.uppercased())
            .font(.headline)
    }
    
    var contentRating: some View {
        HStack {
            Text("\(self.presenter.gameDetail?.rating ?? 0.0)")
                .font(.system(size: 14))
            Image("Star 3")
                .resizable()
                .frame(width: 18, height: 18)
                .scaledToFit()
        }
        
    }
    
    var description: some View {
        Text(self.presenter.gameDetail?.description ?? "")
            .font(.system(size: 14))
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            self.headerTitle(self.presenter.gameDetail?.nameOriginal ?? "")
            contentRating
            description
        }
    }
    
}
