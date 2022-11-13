//
//  Game.swift
//  Alias
//
//  Created by shio andghuladze on 06.10.22.
//

import Foundation

enum GameMode{
    case Arcade
    case Classic
}

class Game{
    var gameMode: GameMode? {
        didSet{
            NotificationCenter.default.post(name: Game.notificationName, object: gameMode)
        }
    }
    private var teams: [Team] = []
    private var sortedTeams = [Team]()
    
    var bonusRoundTeams = [Team]()
    var time: Int = 10
    var points: Int = 3
    var currentRoundType = RoundType.RegularRound
    var currentTeamIndex = -1
    var roundLiveData = LiveData<Round>()
    var roundFinished = true
    var gameFinished = false
    var onEndGame: ()-> Void = {}
    
    static let notificationName = NSNotification.Name("Game")
    static var instance: Game?
    static func getInstance()-> Game{
        guard let instance = instance else {
            instance = Game()
            return instance!
        }
        
        return instance
    }
    
    func reset(){
        Self.instance = Game()
    }
    
    func restart(){
        roundFinished = true
        currentRoundType = .RegularRound
        currentTeamIndex = -1
        bonusRoundTeams.removeAll()
        sortedTeams = teams
        roundLiveData = LiveData()
        gameFinished = false
        teams.forEach{
            $0.isWinning = false
            $0.points = 0
        }
    }
    
    func submitRound(teamPoints: Int){
        teams[currentTeamIndex].points = teamPoints
        roundFinished = true
        sortTeams()
        loadNextRound()
    }
    
    func startNextRound(){
        roundFinished = false
        roundLiveData.setData(data: Round(type: currentRoundType, team: teams[currentTeamIndex]))
    }
    
    func loadNextRound(){
        let teams = currentRoundType == .RegularRound ? self.teams : bonusRoundTeams
        
        if currentTeamIndex < teams.count - 1{
            currentTeamIndex += 1
        }else if currentRoundType == .RegularRound {
            loadBonusRoundTeamsOrEndGame()
        }else{
            checkBonusRoundResults()
        }
    }
    
    func setTeams(teams: [Team]){
        self.teams = teams
        self.sortedTeams = teams
    }
    
    func getTeams()-> [Team]{
        teams
    }
    
    func getSortedTeams()-> [Team]{
        sortedTeams
    }
    
    private func sortTeams(){
        sortedTeams = teams.sorted{
            $0.isWinning = false
            $1.isWinning = false
            return $0.points > $1.points
        }
        
        sortedTeams[0].isWinning = true
    }
    
    private func checkBonusRoundResults(){
        var winnerPoints = -1
        var nextBonusRoundTeams = [Team]()
        
        for i in 0..<bonusRoundTeams.count {
            let team = bonusRoundTeams[i]
            
            if team.points > winnerPoints {
                nextBonusRoundTeams = [team]
                winnerPoints = team.points
            } else if team.points == winnerPoints {
                nextBonusRoundTeams.append(team)
            }
        }
        
        if nextBonusRoundTeams.count == 1 {
            onEndGame()
            gameFinished = true
        } else {
            bonusRoundTeams = nextBonusRoundTeams
            currentTeamIndex = -1
            loadNextRound()
        }
        
    }
    
    private func loadBonusRoundTeamsOrEndGame(){
        teams.forEach { team in
            if team.points >= points {
                bonusRoundTeams.append(team)
            }
        }
        
        if bonusRoundTeams.count == 1 {
            onEndGame()
            gameFinished = true
        } else if bonusRoundTeams.count >= 0{
            currentTeamIndex = -1
            loadNextRound()
            
            if bonusRoundTeams.count > 1 {
                currentRoundType = .BonusRound
            }
        }
    }
    
}
