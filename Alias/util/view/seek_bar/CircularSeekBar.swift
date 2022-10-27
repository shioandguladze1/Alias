//
//  CircularSeekBar.swift
//  Alias
//
//  Created by shio andghuladze on 26.10.22.
//

import Foundation
import UIKit

class CircularSeekBar: UIView {
    var progress: Int
    
    private let increaseButton: UIButton = {
        let button = getRoundButtonWithIcon(size: 50, padding: 20, iconName: "plus")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let decreaseButton: UIButton = {
        let button = getRoundButtonWithIcon(size: 50, padding: 20, iconName: "minus")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        self.progress = 0
        super.init(coder: coder)
        setUpSubViews()
    }
    
    override init(frame: CGRect) {
        self.progress = 0
        super.init(frame: frame)
        setUpSubViews()
    }
    
    init(progress: Int){
        self.progress = progress
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setUpSubViews()
    }
    
    private func setUpSubViews(){
        addSubview(increaseButton)
        addSubview(decreaseButton)
        addSubview(valueLabel)
        setUpValueLabel()
        setUpIncreaseButton()
        setUpDecreaseButton()
    }
    
    private func setUpValueLabel(){
        NSLayoutConstraint.activate([
            valueLabel.heightAnchor.constraint(equalTo: heightAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.leftAnchor.constraint(equalTo: decreaseButton.rightAnchor, constant: 20),
            valueLabel.rightAnchor.constraint(equalTo: increaseButton.leftAnchor, constant: -20)
        ])
        
        valueLabel.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        valueLabel.textAlignment = .center
        valueLabel.textColor = .white
        valueLabel.layer.cornerRadius = 20
        valueLabel.clipsToBounds = true
        valueLabel.text = String(progress)
    }
    
    private func setUpIncreaseButton(){
        NSLayoutConstraint.activate([
            increaseButton.rightAnchor.constraint(equalTo: rightAnchor),
            increaseButton.heightAnchor.constraint(equalTo: heightAnchor),
            increaseButton.widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    private func setUpDecreaseButton(){
        NSLayoutConstraint.activate([
            decreaseButton.leftAnchor.constraint(equalTo: leftAnchor),
            decreaseButton.heightAnchor.constraint(equalTo: heightAnchor),
            decreaseButton.widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
}
