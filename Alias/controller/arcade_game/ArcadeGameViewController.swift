//
//  ArcadeGameViewController.swift
//  Alias
//
//  Created by shio andghuladze on 31.10.22.
//

import UIKit

class ArcadeGameViewController: BaseGameViewController {
    private var currentTeamPoints = 0
    
    private let wordView: OptionsLabel = {
        let view = OptionsLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let increaseButton: UIButton = {
        let button = getRoundButtonWithIcon(size: 45, padding: 20, iconName: "checkmark")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let decreaseButton: UIButton = {
        let button = getRoundButtonWithIcon(size: 45, padding: 20, iconName: "xmark")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let sceneImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWordView()
        setUpIncreaseButton()
        setUpDecreaseButton()
        setUpSceneImageView()
    }
    
    override func prepareUIForNextRound(round: Round) {
        super.prepareUIForNextRound(round: round)
        currentTeamPoints = round.team.points
        increaseButton.isUserInteractionEnabled = true
        decreaseButton.isUserInteractionEnabled = true
        wordView.setText(text: getRandomWord())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        increaseButton.setGradientBackground(
            gradientDirection: .Horizontal,
            colors: [
                GlobalColorProvider.getColor(color: .subtlePurple),
                GlobalColorProvider.getColor(color: .subtlePink)
            ],
            locations: [0.4]
        )
    }
    
    private func setUpSceneImageView(){
        view.addSubview(sceneImageView)
        
        sceneImageView.image = UIImage(named: "arcade_scene")
        
        NSLayoutConstraint.activate([
            sceneImageView.leftAnchor.constraint(equalTo: decreaseButton.leftAnchor, constant: 16),
            sceneImageView.rightAnchor.constraint(equalTo: increaseButton.rightAnchor, constant: -16),
            sceneImageView.topAnchor.constraint(equalTo: decreaseButton.bottomAnchor, constant: 16),
            sceneImageView.heightAnchor.constraint(equalTo: sceneImageView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func setUpWordView(){
        view.addSubview(wordView)
        
        wordView.setText(text: getRandomWord())
        wordView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            wordView.topAnchor.constraint(equalTo: countDownTimerView.bottomAnchor, constant: 32),
            wordView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 64),
            wordView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -64),
            wordView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setUpIncreaseButton(){
        view.addSubview(increaseButton)
        
        increaseButton.tag = 1
        increaseButton.addTarget(self, action: #selector(changeScore(target:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            increaseButton.rightAnchor.constraint(equalTo: wordView.rightAnchor),
            increaseButton.topAnchor.constraint(equalTo: wordView.bottomAnchor, constant: 12),
            increaseButton.widthAnchor.constraint(equalTo: wordView.widthAnchor, multiplier: 0.35),
            increaseButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setUpDecreaseButton(){
        view.addSubview(decreaseButton)
        
        decreaseButton.tag = -1
        decreaseButton.addTarget(self, action: #selector(changeScore(target:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            decreaseButton.leftAnchor.constraint(equalTo: wordView.leftAnchor),
            decreaseButton.topAnchor.constraint(equalTo: wordView.bottomAnchor, constant: 12),
            decreaseButton.widthAnchor.constraint(equalTo: wordView.widthAnchor, multiplier: 0.35),
            decreaseButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    override func onFinishTimer() {
        increaseButton.isUserInteractionEnabled = false
        decreaseButton.isUserInteractionEnabled = false
        game.submitRound(teamPoints: currentTeamPoints)
        super.onFinishTimer()
    }
    
    @objc func changeScore(target: UIView){
        currentTeamPoints += target.tag
        pointsLabel.text = String(currentTeamPoints)
        wordView.setText(text: getRandomWord())
    }
}
