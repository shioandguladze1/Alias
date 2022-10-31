//
//  ClassicGameViewController.swift
//  Alias
//
//  Created by shio andghuladze on 28.10.22.
//

import UIKit
import CoreData
import BottomSheet

class ClassicGameViewController: BaseGameViewController {
    private var currentTeamPoints = 0
    private var selectedWords = 0
    
    private let wordsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWordsStackView()
    }
    
    override func prepareUIForNextRound(round: Round) {
        super.prepareUIForNextRound(round: round)
        setWordsAreClickable(areClickable: true)
        loadNextSetOfWords()
        currentTeamPoints = round.team.points
    }
    
    private func setUpWordsStackView(){
        view.addSubview(wordsStackView)
        
        NSLayoutConstraint.activate([
            wordsStackView.topAnchor.constraint(equalTo: countDownTimerView.bottomAnchor, constant: 32),
            wordsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            wordsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)
        ])
        
        wordsStackView.layer.cornerRadius = 10
        wordsStackView.clipsToBounds = true
        
        populateStackView()
    }
    
    private func setWordsAreClickable(areClickable: Bool){
        wordsStackView.arrangedSubviews.forEach { view in
            view.isUserInteractionEnabled = areClickable
        }
    }
    
    private func wordClicked(selected: Bool){
        if selected {
            currentTeamPoints += 1
            selectedWords += 1
        } else {
            currentTeamPoints -= 1
            selectedWords -= 1
        }
        
        if selectedWords == 5 {
            loadNextSetOfWords()
        }
        
        pointsLabel.text = String(currentTeamPoints)
    }
    
    private func populateStackView(){
        (0...4).forEach { _ in
            let label = OptionsLabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 50).isActive = true
            label.onClick = wordClicked(selected:)
            label.setText(text: getRandomWord())
            
            wordsStackView.addArrangedSubview(label)
        }
    }
    
    override func onFinishTimer() {
        setWordsAreClickable(areClickable: false)
        game.submitRound(teamPoints: currentTeamPoints)
    }
    
    private func loadNextSetOfWords(){
        selectedWords = 0
        wordsStackView.arrangedSubviews.forEach { view in
            
            if let wordLabel = view as? OptionsLabel {
                wordLabel.isSelected = false
                wordLabel.setText(text: getRandomWord())
                wordLabel.onClick = wordClicked(selected:)
            }
            
        }
    }
    
}
