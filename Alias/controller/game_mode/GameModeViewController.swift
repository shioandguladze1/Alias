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
    private var game: Game?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = GlobalColorProvider.getColor(color: .SecondWhite).asUIColor()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sceneImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game.getInstance()
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        setUpViews()
        setUpArcadeButton()
        setUpClassicButton()
        setUpTitleLabel()
        addGameModeObserver()
        setUpSceneImageView()
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
    
    private func setUpSceneImageView(){
        guard let classicButton = classicButton else {
            return
        }
        
        view.addSubview(sceneImageView)
        sceneImageView.image = UIImage(named: "game_mode_scene")
        
        NSLayoutConstraint.activate([
            sceneImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            sceneImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            sceneImageView.bottomAnchor.constraint(equalTo: classicButton.topAnchor, constant: -32),
            sceneImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
        ])
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
    
    override func onBackPressed(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended {
            
            navigationController?.popViewController(animated: true)
            game?.reset()
            
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
        
        (parent as? PagerController)?.navigateForward(index: 1)
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
