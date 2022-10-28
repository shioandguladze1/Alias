//
//  ClassicGameViewController.swift
//  Alias
//
//  Created by shio andghuladze on 28.10.22.
//

import UIKit
import CoreData

class ClassicGameViewController: UIViewController {
    private let game = Game.getInstance()
    private var count = Game.getInstance().time
    private var timer: Timer?
    private var currentTeamPoints = 0
    private let databaseHelper = WordsDataBaseHelper()
    
    private let countDownTimerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let countDownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let wordsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTick), userInfo: nil, repeats: true)
        game.teams = [Team(id: 2, name: "asdasdas"), Team(id: 3, name: "asdasdddddd")]
        setUpCountDownTimerView()
        setUpCountDownLabel()
        setUpPointsLabel()
        setUpTeamNameLabel()
        setUpWordsStackView()
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
    
    private func setUpTeamNameLabel(){
        view.addSubview(teamNameLabel)
        
        NSLayoutConstraint.activate([
            teamNameLabel.bottomAnchor.constraint(equalTo: pointsLabel.topAnchor, constant: -12),
            teamNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        teamNameLabel.textColor = .white
        teamNameLabel.font = .systemFont(ofSize: 20)
        teamNameLabel.text = game.teams[game.currentTeamIndex].name
    }
    
    private func setUpPointsLabel(){
        view.addSubview(pointsLabel)
        
        NSLayoutConstraint.activate([
            pointsLabel.widthAnchor.constraint(equalToConstant: 45),
            pointsLabel.heightAnchor.constraint(equalToConstant: 45),
            pointsLabel.rightAnchor.constraint(equalTo: countDownTimerView.rightAnchor, constant: 15),
            pointsLabel.topAnchor.constraint(equalTo: countDownTimerView.topAnchor, constant: -15)
        ])
        
        pointsLabel.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        pointsLabel.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        pointsLabel.text = "0"
        pointsLabel.textAlignment = .center
        pointsLabel.textColor = .white
        pointsLabel.font = .systemFont(ofSize: 15)
        pointsLabel.makeOval()
    }
    
    private func setUpCountDownLabel(){
        view.addSubview(countDownLabel)
        
        NSLayoutConstraint.activate([
            countDownLabel.centerXAnchor.constraint(equalTo: countDownTimerView.centerXAnchor),
            countDownLabel.centerYAnchor.constraint(equalTo: countDownTimerView.centerYAnchor),
            countDownLabel.widthAnchor.constraint(equalTo: countDownTimerView.widthAnchor),
            countDownLabel.heightAnchor.constraint(equalTo: countDownTimerView.heightAnchor)
        ])
        
        countDownLabel.textColor = .white
        countDownLabel.font = .systemFont(ofSize: 50)
        countDownLabel.text = String(game.time)
        countDownLabel.textAlignment = .center
    }
    
    private func setUpCountDownTimerView(){
        view.addSubview(countDownTimerView)
        
        NSLayoutConstraint.activate([
            countDownTimerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: view.frame.height * 0.15),
            countDownTimerView.widthAnchor.constraint(equalToConstant: 90),
            countDownTimerView.heightAnchor.constraint(equalToConstant: 90),
            countDownTimerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        countDownTimerView.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        
        countDownTimerView.setGradientBackground(
            gradientDirection: .Horizontal,
            colors: [
                GlobalColorProvider.getColor(color: .subtlePurple),
                GlobalColorProvider.getColor(color: .subtlePink)
            ],
            locations: [0.4]
        )
        
        countDownTimerView.makeOval()
    }
    
    private func wordClicked(selected: Bool){
        if selected {
            currentTeamPoints += 1
        } else {
            currentTeamPoints -= 1
        }
        
        if currentTeamPoints % 5 == 0 {
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
    
    private func getRandomWord()-> String {
        let randomId = Int.random(in: 7331...9439)
        let word = databaseHelper.readWords(condition: "WHERE id=\(randomId)")[0]
        return word.keyword
    }
    
    private func loadNextSetOfWords(){
        wordsStackView.arrangedSubviews.forEach { view in
            
            if let wordLabel = view as? OptionsLabel {
                wordLabel.isSelected = false
                wordLabel.setText(text: getRandomWord())
            }
            
        }
    }
    
    @objc private func onTick(){
        if count > 0 {
            count -= 1
            countDownLabel.text = String(count)
        }else {
            timer?.invalidate()
        }
    }
    
}
