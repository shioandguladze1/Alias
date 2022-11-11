//
//  TeamsViewController.swift
//  Alias
//
//  Created by shio andghuladze on 07.10.22.
//

import UIKit

class TeamsViewController: BaseViewController {
    private let game = Game.getInstance()
    override var isBackNavigationEnabled: Bool { false }
    
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
    
    private let addButton: UIButton = {
        let button = getRoundButtonWithIcon(size: 60, padding: 30, iconName: "plus")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let teamsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let continueButton: UIButton = {
        let button = getRoundButtonWithIcon(size: 60, padding: 40, iconName: "arrow.right")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        setUpClassicSnakeButton()
        setUpArcadeSnakeButton()
        setUpAddButton()
        addGameModeObserver()
        changeSnakeButtonColors()
        setUpTeamsStackView()
        setUpImageView()
        setUpContinueButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveTeams()
    }
    
    private func setUpContinueButton(){
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate(
            [
                continueButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -12),
                continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                continueButton.widthAnchor.constraint(equalToConstant: 60),
                continueButton.heightAnchor.constraint(equalToConstant: 60)
            ]
        )
        
        continueButton.addTarget(self, action: #selector(navigateToTimeAndPoints), for: .touchUpInside)
    }
    
    private func setUpImageView(){
        view.addSubview(imageView)
        imageView.image = UIImage(named: "teams_scene")
        
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: view.frame.height * 0.1),
                imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, constant: 1.2),
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }
    
    private func setUpTeamsStackView(){
        view.addSubview(teamsStackView)
        teamsStackView.backgroundColor = .clear
        teamsStackView.spacing = 8
        teamsStackView.addArrangedSubview(getTeamTextField(id: 1))
        teamsStackView.addArrangedSubview(getTeamTextField(id: 2))
        
        NSLayoutConstraint.activate([
            teamsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            teamsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            teamsStackView.bottomAnchor.constraint(equalTo: classicSnakeButton.topAnchor, constant: -8)
        ])
        
    }
    
    private func setUpAddButton(){
        view.addSubview(addButton)
        NSLayoutConstraint.activate(
            [
                addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                addButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                addButton.widthAnchor.constraint(equalToConstant: 60),
                addButton.heightAnchor.constraint(equalToConstant: 60)
            ]
        )
        
        addButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addTeams)))
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
    
    private func saveTeams(){
        var teams = [Team]()
        var id = 1
        
        teamsStackView.arrangedSubviews.forEach { view in
            
            if let textField = view as? UITextField {
                let text = textField.text.ifNotNullOrEmpty(defaultValue: "Team\(id)")
                teams.append(Team(id: id, name: text))
                id += 1
            }
            
        }
        
        game.setTeams(teams: teams)
    }
    
    @objc private func navigateToTimeAndPoints(){
        (parent as? ViewController)?.navigateForward(index: 2)
    }
    
    @objc private func addTeams(){
        let teams = teamsStackView.arrangedSubviews
        
        if teams.count >= 6 {
            return
        }else if teams.count == 3 {
            imageView.hideWithFade(duration: 0.2)
        }
        
        let currentNumber = teams.count + 1
        teamsStackView.addArrangedSubview(getTeamTextField(id: currentNumber))
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
