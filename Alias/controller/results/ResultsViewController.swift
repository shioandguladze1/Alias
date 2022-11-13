//
//  ResultsViewController.swift
//  Alias
//
//  Created by shio andghuladze on 11.11.22.
//

import Foundation
import UIKit

class ResultsViewController: BaseViewController {
    private let game = Game.getInstance()
    override var isBackNavigationEnabled: Bool {
        false
    }
    
    private let resultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teamsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let homeButton: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.isUserInteractionEnabled = true
        return imageview
    }()
    
    private let sceneImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private let restartButton: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.isUserInteractionEnabled = true
        return imageview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        setUpResultsLabel()
        setUpResultsCollectionView()
        setUpSceneImageView()
        setUpHomeButton()
        setUpRestartButton()
    }
    
    private func setUpRestartButton(){
        view.addSubview(restartButton)
        
        restartButton.image = UIImage(named: "ic_restart")
        restartButton.contentMode = .scaleAspectFit
        restartButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(restartGame)))
        
        NSLayoutConstraint.activate([
            restartButton.centerYAnchor.constraint(equalTo: sceneImageView.centerYAnchor),
            restartButton.leftAnchor.constraint(equalTo: sceneImageView.rightAnchor, constant: 35),
            restartButton.widthAnchor.constraint(equalToConstant: 40),
            restartButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpSceneImageView(){
        view.addSubview(sceneImageView)
        
        sceneImageView.contentMode = .scaleAspectFit
        sceneImageView.image = UIImage(named: "results_scene")
        
        NSLayoutConstraint.activate([
            sceneImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sceneImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sceneImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            sceneImageView.widthAnchor.constraint(equalTo: sceneImageView.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setUpHomeButton(){
        view.addSubview(homeButton)
        
        homeButton.image = UIImage(systemName: "house.fill")
        homeButton.tintColor = .white
        homeButton.contentMode = .scaleAspectFit
        homeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnToHome)))
        
        NSLayoutConstraint.activate([
            homeButton.centerYAnchor.constraint(equalTo: sceneImageView.centerYAnchor),
            homeButton.rightAnchor.constraint(equalTo: sceneImageView.leftAnchor, constant: -35),
            homeButton.widthAnchor.constraint(equalToConstant: 40),
            homeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpResultsCollectionView(){
        view.addSubview(teamsStackView)
        
        teamsStackView.axis = .vertical
        teamsStackView.spacing = 16
        arrangeTeams(teams: game.getSortedTeams())
        
        NSLayoutConstraint.activate([
            teamsStackView.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor),
            teamsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -64),
            teamsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpResultsLabel(){
        view.addSubview(resultsLabel)
        
        resultsLabel.textColor = .white
        resultsLabel.font = .boldSystemFont(ofSize: 30)
        resultsLabel.text = "results".localized()
        
        NSLayoutConstraint.activate([
            resultsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1),
            resultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func arrangeTeams(teams: [Team]){
        teams.forEach { team in
            let view = TeamStatsView()
            view.setUp(team: team)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 45).isActive = true
            teamsStackView.addArrangedSubview(view)
        }
    }
    
    @objc func returnToHome(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func restartGame(){
        guard let navigationController = navigationController else {
            return
        }
        
        game.restart()
        navigationController.viewControllers.remove(at: navigationController.viewControllers.count - 2)
        let vc: UIViewController
        
        if game.gameMode == .Arcade {
            vc = ArcadeGameViewController()
        }else {
            vc = ClassicGameViewController()
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
