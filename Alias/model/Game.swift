//
//  Game.swift
//  Alias
//
//  Created by shio andghuladze on 06.10.22.
//

import Foundation

enum GameMode{
    case Arcade
    case Classic
}

class Game{
    var gameMode: GameMode? {
        didSet{
            NotificationCenter.default.post(name: Game.notificationName, object: gameMode)
        }
    }
    var teams: [Team] = []
    
    static let notificationName = NSNotification.Name("Game")
    static var instance: Game?
    static func getInstance()-> Game{
        guard let instance = instance else {
            instance = Game()
            return instance!
        }
        
        return instance
    }
}
