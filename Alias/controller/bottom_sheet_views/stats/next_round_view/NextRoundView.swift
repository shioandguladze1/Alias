//
//  NextRoundView.swift
//  Alias
//
//  Created by shio andghuladze on 30.10.22.
//

import UIKit

class NextRoundView: UIView {
    private let nextRoundButton: UIButton = {
        let button = getRoundButtonWithIcon(size: 60, padding: 40, iconName: "arrow.right")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextRoundLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var onNextRoundButtonClick: (()-> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    private func initUI(){
        setUpStatsButton()
        setUpStatsLabel()
        backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
    }
    
    private func setUpStatsButton(){
        addSubview(nextRoundButton)
        
        nextRoundButton.addTarget(self, action: #selector(nextRoundButtonClick), for: .touchUpInside)
        nextRoundButton.backgroundColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
        
        NSLayoutConstraint.activate([
            nextRoundButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            nextRoundButton.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -16),
            nextRoundButton.widthAnchor.constraint(equalToConstant: 60),
            nextRoundButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setUpStatsLabel(){
        addSubview(nextRoundLabel)
        
        nextRoundLabel.textColor = .white
        nextRoundLabel.font = .systemFont(ofSize: 20)
        nextRoundLabel.text = "next_round".localized()
        
        NSLayoutConstraint.activate([
            nextRoundLabel.centerYAnchor.constraint(equalTo: nextRoundButton.centerYAnchor),
            nextRoundLabel.rightAnchor.constraint(equalTo: nextRoundButton.leftAnchor, constant: -10)
        ])
    }
    
    @objc private func nextRoundButtonClick(){
        onNextRoundButtonClick?()
    }
    
}
