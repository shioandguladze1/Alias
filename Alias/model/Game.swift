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
    var gameMode: GameMode?
    
    static var instance: Game?
    static func getInstance()-> Game{
        guard let instance = instance else {
            instance = Game()
            return instance!
        }
        
        return instance
    }
}
