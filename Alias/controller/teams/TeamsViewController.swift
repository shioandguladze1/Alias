//
//  TeamsViewController.swift
//  Alias
//
//  Created by shio andghuladze on 07.10.22.
//

import UIKit

class TeamsViewController: UIViewController {
    private let game = Game.getInstance()
        
    private let classicSnakeButton: SnakeButton = {
        let button = SnakeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let arcadeSnakeButton: SnakeButton = {
        let button = SnakeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        setUpClassicSnakeButton()
        setUpArcadeSnakeButton()
        addGameModeObserver()
        changeSnakeButtonColors()
    }
    
    private func setUpClassicSnakeButton(){
        view.addSubview(classicSnakeButton)
        classicSnakeButton.tag = 0
        
        NSLayoutConstraint.activate(
            [
                classicSnakeButton.heightAnchor.constraint(equalToConstant: 56),
                classicSnakeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.7),
                classicSnakeButton.widthAnchor.constraint(equalTo: view.widthAnchor)
            ]
        )
        
        classicSnakeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeGameMode(_:))))
    }
    
    private func setUpArcadeSnakeButton(){
        view.addSubview(arcadeSnakeButton)
        arcadeSnakeButton.tag = 1
        
        NSLayoutConstraint.activate(
            [
                arcadeSnakeButton.heightAnchor.constraint(equalToConstant: 56),
                arcadeSnakeButton.topAnchor.constraint(equalTo: classicSnakeButton.bottomAnchor, constant: 8),
                arcadeSnakeButton.widthAnchor.constraint(equalTo: view.widthAnchor)
            ]
        )
        
        arcadeSnakeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeGameMode(_:))))
    }
    
    @objc private func changeGameMode(_ gesture: UITapGestureRecognizer? = nil){
        if let snakeButton = gesture?.view as? SnakeButton {
            switch snakeButton.tag{
            case 0:
                game.gameMode = .Classic
            case 1:
                game.gameMode = .Arcade
            default: break
            }
        }
    }
    
    @objc private func changeSnakeButtonColors(){
        switch game.gameMode{
        case .Arcade:
            arcadeSnakeButton.isActive = true
            classicSnakeButton.isActive = false
        case.Classic:
            classicSnakeButton.isActive = true
            arcadeSnakeButton.isActive = false
        default:
            return
        }
    }
    
    private func addGameModeObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(changeSnakeButtonColors), name: Game.notificationName, object: nil)
    }

}
