//
//  OptionsLabel.swift
//  Alias
//
//  Created by shio andghuladze on 28.10.22.
//

import Foundation
import UIKit

class OptionsLabel: UIView{
    var isSelected = false {
        didSet {
            changeUI()
        }
    }
    
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var onClick: ((Bool)-> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpOptionsLabel()
        backgroundColor = .white
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelection)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpOptionsLabel()
        backgroundColor = .white
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelection)))
    }
    
    @objc private func handleSelection(){
        isSelected = !isSelected
        onClick?(isSelected)
        changeUI()
    }
    
    private func changeUI(){
        if isSelected {
            setGradientBackground(
                gradientDirection: .Horizontal,
                colors: [
                    GlobalColorProvider.getColor(color: .subtlePurple),
                    GlobalColorProvider.getColor(color: .subtlePink)
                ],
                locations: [0.4]
            )
            
            optionLabel.textColor = .white
        } else {
            backgroundColor = .white
            optionLabel.textColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
            layer.sublayers = []
            addSubview(optionLabel)
        }
    }
    
    private func setUpOptionsLabel(){
        addSubview(optionLabel)
        
        optionLabel.font = .boldSystemFont(ofSize: 24)
        optionLabel.textColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        
        NSLayoutConstraint.activate([
            optionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setText(text: String){
        optionLabel.text = text
    }
    
}
