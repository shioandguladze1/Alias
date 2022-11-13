//
//  BaseGameViewController.swift
//  Alias
//
//  Created by shio andghuladze on 31.10.22.
//

import UIKit

class BaseGameViewController: BaseViewController, ForheitRoundViewDelegate {
    let game = Game.getInstance()
    private var count = Game.getInstance().time
    private var timer: Timer?
    private let databaseHelper = WordsDataBaseHelper()
    
    let countDownTimerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let countDownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    private let forheitRoundView = ForfeitRoundView()
    private let bottomSheetFooterView = NextRoundView()
    private var statsBottomSheetController: UIViewController?
    private var forheitRoundBottomSheetcontroller: UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        setUpCountDownTimerView()
        setRoundObserver()
        setUpCountDownLabel()
        setUpStatsButton()
        setUpStatsLabel()
        game.loadNextRound()
        game.startNextRound()
        bottomSheetFooterView.onNextRoundButtonClick = {
            self.game.startNextRound()
        }
        forheitRoundView.delegate = self
        game.onEndGame = navigateToResults
    }
    
    private func setRoundObserver(){
        let observer = Observer<Round>{ round in
            self.prepareUIForNextRound(round: round)
        }

        game.roundLiveData.addObserver(observer: observer)
    }
    
    func prepareUIForNextRound(round: Round){
        setUpPointsLabel(points: round.team.points)
        setUpTeamNameLabel(teamName: round.team.name)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTick), userInfo: nil, repeats: true)
        count = self.game.time
        countDownLabel.text = String(self.count)
        statsBottomSheetController?.dismiss(animated: true)
        statsButton.setChildImageViewImage(image: UIImage(systemName: "arrow.up")!)
        statsButton.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        statsLabel.text = "score".localized()
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
        statsLabel.text = "score".localized()
        
        NSLayoutConstraint.activate([
            statsLabel.centerYAnchor.constraint(equalTo: statsButton.centerYAnchor),
            statsLabel.rightAnchor.constraint(equalTo: statsButton.leftAnchor, constant: -10)
        ])
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
    
    @objc private func onStatsButtonClick(){
        if game.roundFinished {
            game.startNextRound()
        }else {
            openStats()
        }
    }
    
    private func openStats(){
        guard !game.gameFinished else {
            return
        }
        
        statCollectionView.setData(teams: game.getSortedTeams())
        let height = 48 + game.getTeams().count * 45 + (game.getTeams().count - 1) * 16
        
        if game.roundFinished {
            statsBottomSheetController = showBottomSheetview(height: CGFloat(height), bottomView: statCollectionView, footerView: bottomSheetFooterView, footerHeight: 90)
        }else {
            statsBottomSheetController = showBottomSheetview(height: CGFloat(height), bottomView: statCollectionView)
        }
    }
    
    func getRandomWord()-> String {
        let word = databaseHelper.readWords(condition: "ORDER BY RANDOM() LIMIT 1")[0]
        return word.keyword
    }
    
    func onFinishTimer(){
        timer?.invalidate()
        statsBottomSheetController?.dismiss(animated: true)
        forheitRoundBottomSheetcontroller?.dismiss(animated: true)
        statsButton.setChildImageViewImage(image: UIImage(systemName: "arrow.right")!)
        statsLabel.text = "next_round".localized()
        statsButton.backgroundColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
        openStats()
    }
    
    private func navigateToResults(){
        let vc = ResultsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func onTick(){
        if count > 0 {
            count -= 1
            countDownLabel.text = String(count)
        }else {
            onFinishTimer()
        }
    }
    
    func onForheitRound() {
        onDismiss()
        onFinishTimer()
    }
    
    func onForheitGame() {
        onDismiss()
        navigationController?.popToRootViewController(animated: true)
        game.reset()
    }
    
    func onDismiss() {
        forheitRoundBottomSheetcontroller?.dismiss(animated: true)
    }
    
    override func onBackPressed(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended {
            forheitRoundBottomSheetcontroller = showBottomSheetview(height: 200, bottomView: forheitRoundView)
        }
    }

}
