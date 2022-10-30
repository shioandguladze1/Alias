//
//  StatsBottomSheetView.swift
//  Alias
//
//  Created by shio andghuladze on 30.10.22.
//

import Foundation
import UIKit

class StatsCollectionView: UIView {
    private let teamsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    func setData(teams: [Team]){
        if teamsStackView.arrangedSubviews.count != teams.count {
            teamsStackView.arrangedSubviews.forEach { view in
                teamsStackView.removeArrangedSubview(view)
            }
            
            createViews(teams: teams)
        }else {
            changeDataOnViews(teams: teams)
        }
    }
    
    private func createViews(teams: [Team]){
        teams.forEach { team in
            let view = TeamStatsView()
            view.setUp(team: team)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 45).isActive = true
            teamsStackView.addArrangedSubview(view)
        }
    }
    
    private func changeDataOnViews(teams: [Team]){
        for i in 0..<teamsStackView.arrangedSubviews.count {
            
            if let statView = teamsStackView.arrangedSubviews[i] as? TeamStatsView {
                statView.setUp(team: teams[i])
            }
            
        }
    }
    
    private func initUI(){
        setUpStackView()
        backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
    }
    
    private func setUpStackView(){
        addSubview(teamsStackView)
        
        teamsStackView.axis = .vertical
        teamsStackView.spacing = 16
                
        NSLayoutConstraint.activate([
            teamsStackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 16),
            teamsStackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -16),
            teamsStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
