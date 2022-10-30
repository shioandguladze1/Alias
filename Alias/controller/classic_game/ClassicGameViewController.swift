//
//  ClassicGameViewController.swift
//  Alias
//
//  Created by shio andghuladze on 28.10.22.
//

import UIKit
import CoreData
import BottomSheet

class ClassicGameViewController: UIViewController {
    private let game = Game.getInstance()
    private var count = Game.getInstance().time
    private var timer: Timer?
    private var currentTeamPoints = 0
    private var selectedWords = 0
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
    
    private let statsButton: UIButton = {
        let button = getRoundButtonWithIcon(size: 60, padding: 40, iconName: "arrow.up")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statCollectionView = StatsCollectionView()
    private let bottomSheetFooterView = NextRoundView()
    private var bottomSheetController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        game.teams = [Team(id: 1, name: "Team 1(4 5 6)"), Team(id: 2, name: "Team 2(4 4)"), Team(id: 3, name: "Team 3(4 5 5)"), Team(id: 4, name: "asdasd"), Team(id: 35, name: "asdasdasd")]
        setUpCountDownTimerView()
        setUpWordsStackView()
        setRoundObserver()
        setUpCountDownLabel()
        setUpStatsButton()
        setUpStatsLabel()
        game.loadNextRound()
        bottomSheetFooterView.onNextRoundButtonClick = {
            self.game.loadNextRound()
        }
    }
    
    private func setRoundObserver(){
        let observer = Observer<Round>{ round in
            self.prepareUIForNextRound(round: round)
        }

        game.roundLiveData.addObserver(observer: observer)
    }
    
    private func prepareUIForNextRound(round: Round){
        setUpPointsLabel(points: round.team.points)
        setUpTeamNameLabel(teamName: round.team.name)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTick), userInfo: nil, repeats: true)
        count = self.game.time
        countDownLabel.text = String(self.count)
        currentTeamPoints = round.team.points
        loadNextSetOfWords()
        bottomSheetController?.dismiss(animated: true)
        setWordsAreClickable(areClickable: true)
        statsButton.setChildImageViewImage(image: UIImage(systemName: "arrow.up")!)
        statsButton.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        statsLabel.text = "angarishi*translate*"
    }
    
    private func setUpStatsButton(){
        view.addSubview(statsButton)
        
        statsButton.addTarget(self, action: #selector(onStatsButtonClick), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            statsButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            statsButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            statsButton.widthAnchor.constraint(equalToConstant: 60),
            statsButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setUpStatsLabel(){
        view.addSubview(statsLabel)
        
        statsLabel.textColor = .white
        statsLabel.font = .systemFont(ofSize: 20)
        statsLabel.text = "ანგარიში"
        
        NSLayoutConstraint.activate([
            statsLabel.centerYAnchor.constraint(equalTo: statsButton.centerYAnchor),
            statsLabel.rightAnchor.constraint(equalTo: statsButton.leftAnchor, constant: -10)
        ])
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
    
    private func setUpTeamNameLabel(teamName: String){
        view.addSubview(teamNameLabel)
        
        NSLayoutConstraint.activate([
            teamNameLabel.bottomAnchor.constraint(equalTo: pointsLabel.topAnchor, constant: -12),
            teamNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        teamNameLabel.textColor = .white
        teamNameLabel.font = .systemFont(ofSize: 20)
        teamNameLabel.text = teamName
    }
    
    private func setUpPointsLabel(points: Int){
        view.addSubview(pointsLabel)
        
        NSLayoutConstraint.activate([
            pointsLabel.widthAnchor.constraint(equalToConstant: 45),
            pointsLabel.heightAnchor.constraint(equalToConstant: 45),
            pointsLabel.rightAnchor.constraint(equalTo: countDownTimerView.rightAnchor, constant: 15),
            pointsLabel.topAnchor.constraint(equalTo: countDownTimerView.topAnchor, constant: -15)
        ])
        
        pointsLabel.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        pointsLabel.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        pointsLabel.text = String(points)
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
    
    private func setWordsAreClickable(areClickable: Bool){
        wordsStackView.arrangedSubviews.forEach { view in
            view.isUserInteractionEnabled = areClickable
        }
    }
    
    @objc private func onStatsButtonClick(){
        if game.roundFinished {
            game.loadNextRound()
        }else {
            openStats()
        }
    }
    
    private func openStats(){
        statCollectionView.setData(teams: game.teams)
        let height = 48 + game.teams.count * 45 + (game.teams.count - 1) * 16
        
        if game.roundFinished {
            bottomSheetController = showBottomSheetview(height: CGFloat(height), bottomView: statCollectionView, footerView: bottomSheetFooterView, footerHeight: 90)
        }else {
            bottomSheetController = showBottomSheetview(height: CGFloat(height), bottomView: statCollectionView)
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
    
    private func getRandomWord()-> String {
        let word = databaseHelper.readWords(condition: "ORDER BY RANDOM() LIMIT 1")[0]
        return word.keyword
    }
    
    private func loadNextSetOfWords(){
        selectedWords = 0
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
            game.submitRound(teamPoints: currentTeamPoints)
            bottomSheetController?.dismiss(animated: true)
            setWordsAreClickable(areClickable: false)
            statsButton.setChildImageViewImage(image: UIImage(systemName: "arrow.right")!)
            statsLabel.text = "nextRound*translate*"
            statsButton.backgroundColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
            openStats()
        }
    }
    
}
