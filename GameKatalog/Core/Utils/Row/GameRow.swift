//
//  GameRow.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRow: View {
    
    var gameModel: GameModel
    
    var body: some View {
        HStack {
            imageGame
            content
        }.padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
    }
}

extension GameRow {
    var imageGame: some View {
        WebImage(url: URL(string: gameModel.backgroundImage ?? ""))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .frame(width: 74, height: 74)
            .cornerRadius(8)
            .scaledToFill()
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(gameModel.name ?? "")
                .font(.system(size: 16))
                .bold()
            Text(self.getGenres(gameGenre: self.gameModel.genres ?? []))
                .font(.system(size: 14))
            contentRating
        }.padding(.leading, 8)
    }
    
    var contentRating: some View {
        HStack {
            Text("\(gameModel.rating ?? 0.0)")
                .font(.system(size: 12))
            Image("Star 3")
                .resizable()
                .frame(width: 18, height: 18)
                .scaledToFill()
                
        }
    }
}

extension GameRow {
    func getGenres(gameGenre: [GameGenreModel]) -> String {
        let genres = gameGenre.compactMap {
            $0.name
        }
        return genres.joined(separator: ", ")
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameModel(
            id: 2334,
            slug: "Metal Slug",
            name: "Metal SLUG",
            released: "2021-09-09",
            backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
            rating: 4.5,
            ratingTop: 5, genres: [],
            nameOriginal: "Metal SLUG",
            description: "Description Metal Slug")
        GameRow(gameModel: game).previewLayout(.fixed(width: 400, height: 85))
    }
}
