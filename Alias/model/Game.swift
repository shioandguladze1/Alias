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
    var teams: [Team] = []
    var bonusRoundTeams = [Team]()
    var time: Int = 10
    var points: Int = 3
    var currentRoundType = RoundType.RegularRound
    var currentTeamIndex = -1
    var roundLiveData = LiveData<Round>()
    var roundFinished = true
    var winningTeamIndex = 0
    
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
    
    func submitRound(teamPoints: Int){
        teams[currentTeamIndex].points = teamPoints
        roundFinished = true
        markWinningTeam()
    }
    
    func loadNextRound(){
        let teams = currentRoundType == .RegularRound ? self.teams : bonusRoundTeams
        roundFinished = false
        
        if currentTeamIndex < teams.count - 1{
            currentTeamIndex += 1
            roundLiveData.setData(data: Round(type: currentRoundType, team: teams[currentTeamIndex]))
        }else if currentRoundType == .RegularRound {
            loadBonusRoundTeamsOrEndGame()
        }else{
            checkBonusRoundResults()
        }
    }
    
    private func markWinningTeam(){
        var maxPoints = -1
        var winningTeamIndex = -1
        
        for i in 0..<teams.count {
            let team = teams[i]
            
            if team.points > maxPoints {
                winningTeamIndex = i
                maxPoints = team.points
            }
            
            team.isWinning = false
        }
        
        teams[winningTeamIndex].isWinning = true
        self.winningTeamIndex = winningTeamIndex
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
            endGame()
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
            endGame()
        } else if bonusRoundTeams.count >= 0{
            currentTeamIndex = -1
            loadNextRound()
            
            if bonusRoundTeams.count > 1 {
                currentRoundType = .BonusRound
            }
        }
    }
    
    func endGame(){
        print("game finished")
        let ragaca: String? = nil
        print(ragaca!)
    }
    
}
