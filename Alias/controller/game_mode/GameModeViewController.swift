//
//  GameModeViewController.swift
//  Alias
//
//  Created by shio andghuladze on 06.10.22.
//

import UIKit

class GameModeViewController: BaseViewController {
    private var arcadeButton: PaddingLabel?
    private var classicButton: PaddingLabel?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = GlobalColorProvider.getColor(color: .SecondWhite).asUIColor()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var game: Game?

    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game.getInstance()
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()

        setUpViews()
        setUpArcadeButton()
        setUpClassicButton()
        setUpTitleLabel()
        addGameModeObserver()
    }
    
    private func setUpViews(){
        arcadeButton = getGameModeButton(forKey: classKey!, direction: .Left)
        classicButton = getGameModeButton(forKey: classKey!, direction: .Left)
        view.addSubview(arcadeButton!)
        view.addSubview(classicButton!)
    }
    
    private func setUpTitleLabel(){
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        titleLabel.text = "choose_game_mode".localized()
        titleLabel.sizeToFit()
    }
    
    private func setUpArcadeButton(){
        if let arcadeButton = arcadeButton {
            arcadeButton.paddingLeft = 72
            arcadeButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
            arcadeButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            arcadeButton.topAnchor.constraint(equalTo: classicButton!.bottomAnchor, constant: 8).isActive = true
            arcadeButton.text = "arcade".localized()
            arcadeButton.tag = 1
            arcadeButton.sizeToFit()
            arcadeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeGameMode(_:))))
        }
    }
    
    private func setUpClassicButton(){
        if let classicButton = classicButton {
            classicButton.paddingLeft = 36
            classicButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
            classicButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            classicButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.7).isActive = true
            classicButton.text = "classic".localized()
            classicButton.tag = 0
            classicButton.sizeToFit()
            classicButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeGameMode(_:))))
        }
     
    }
    
    @objc func changeGameMode(_ sender: UITapGestureRecognizer? = nil){
        switch sender?.view?.tag{
        case 0:
            game?.gameMode = .Classic
        case 1:
            game?.gameMode = .Arcade
        default:
            break
        }
                
    }
    
    @objc private func changeButtonColors(){
        switch game?.gameMode{
        case .Classic:
            classicButton?.backgroundColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
            arcadeButton?.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        case .Arcade:
            arcadeButton?.backgroundColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
            classicButton?.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        default:
            return
        }
    }

    private func addGameModeObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(changeButtonColors), name: Game.notificationName, object: nil)
    }

}
