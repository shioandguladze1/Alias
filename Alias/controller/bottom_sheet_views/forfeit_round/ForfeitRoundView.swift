//
//  ForfeitRoundView.swift
//  Alias
//
//  Created by shio andghuladze on 04.11.22.
//

import Foundation
import UIKit

class ForfeitRoundView: UIView{
    var delegate: ForheitRoundViewDelegate?
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let negativeButton: UIButton = {
        let button = getRoundButtonWithIcon(size: 55, padding: 20, iconName: "xmark")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let possitiveButton: UIButton = {
        let button = getRoundButtonWithIcon(size: 55, padding: 20, iconName: "checkmark")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let forheitGameButton: ButtonWithIcon = {
        let button = ButtonWithIcon()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    private func initUI(){
        setUpMessageLabel()
        setUpButtonsStackView()
        setUpNegativeButton()
        setUpPossitiveButton()
        setUpParentview()
        setUpForheitGameButton()
    }
    
    private func setUpParentview(){
        backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private func setUpMessageLabel(){
        addSubview(messageLabel)
        
        messageLabel.textColor = .white
        messageLabel.font = .systemFont(ofSize: 24)
        messageLabel.textAlignment = .center
        messageLabel.text = "do you want to forfeit round?"
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            messageLabel.leftAnchor.constraint(equalTo: leftAnchor),
            messageLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func setUpButtonsStackView(){
        addSubview(buttonsStackView)
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 70
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setUpPossitiveButton(){
        possitiveButton.backgroundColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
        buttonsStackView.addArrangedSubview(possitiveButton)
        possitiveButton.addTarget(self, action: #selector(onForheitRound), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            possitiveButton.heightAnchor.constraint(equalToConstant: 55),
            possitiveButton.widthAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func setUpNegativeButton(){
        negativeButton.backgroundColor = GlobalColorProvider.getColor(color: .subtleRed).asUIColor()
        buttonsStackView.addArrangedSubview(negativeButton)
        negativeButton.addTarget(self, action: #selector(onDismiss), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            negativeButton.heightAnchor.constraint(equalToConstant: 55),
            negativeButton.widthAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func setUpForheitGameButton(){
        addSubview(forheitGameButton)
        
        forheitGameButton.layer.cornerRadius = 5
        forheitGameButton.setText(text: "Forheit Game")
        forheitGameButton.setIcon(image: UIImage(systemName: "house.fill"))
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(onForheitGame))
        forheitGameButton.addGestureRecognizer(gr)
        
        NSLayoutConstraint.activate([
            forheitGameButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            forheitGameButton.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 24),
            forheitGameButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            forheitGameButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func onForheitRound(){
        delegate?.onForheitRound()
    }
    
    @objc func onForheitGame(){
        delegate?.onForheitGame()
    }
    
    @objc func onDismiss(){
        delegate?.onDismiss()
    }
}

protocol ForheitRoundViewDelegate{
    
    func onForheitRound()
    
    func onForheitGame()
    
    func onDismiss()
    
}
