//
//  TeamStatsView.swift
//  Alias
//
//  Created by shio andghuladze on 30.10.22.
//

import UIKit

class TeamStatsView: UIView {
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teamScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teamWinningImageview: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    func setUp(team: Team){
        teamNameLabel.text = team.name
        teamScoreLabel.text = String(team.points)
        teamWinningImageview.image = team.isWinning ? UIImage(named: "first_position") : nil
    }
    
    private func initUI(){
        setUpTeamNameLabel()
        setUpTeamScoreLabel()
        setUpTeamWinningImageView()
        
        backgroundColor = GlobalColorProvider.getColor(color: .SecondWhite).asUIColor()
        layer.cornerRadius = 10
    }
    
    private func setUpTeamNameLabel(){
        addSubview(teamNameLabel)
        
        teamNameLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        teamNameLabel.textColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        
        NSLayoutConstraint.activate([
            teamNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            teamNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setUpTeamScoreLabel(){
        addSubview(teamScoreLabel)
        
        teamScoreLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        teamScoreLabel.textColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        
        NSLayoutConstraint.activate([
            teamScoreLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            teamScoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setUpTeamWinningImageView(){
        addSubview(teamWinningImageview)
        
        teamWinningImageview.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            teamWinningImageview.leftAnchor.constraint(equalTo: teamNameLabel.rightAnchor),
            teamWinningImageview.centerYAnchor.constraint(equalTo: teamNameLabel.centerYAnchor),
            teamWinningImageview.widthAnchor.constraint(equalToConstant: 25),
            teamWinningImageview.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

}
