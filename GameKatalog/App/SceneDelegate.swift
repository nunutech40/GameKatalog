//
//  SceneDelegate.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        let gameListUseCase = Injection.init().provideGameList()
        let gamePresenter = GameListPresenter(gameListUseCase: gameListUseCase)
        
        let contentView = ContentView()
            .environmentObject(gamePresenter)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

