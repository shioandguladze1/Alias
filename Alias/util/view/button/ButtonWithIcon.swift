//
//  ButtonWithIcon.swift
//  Alias
//
//  Created by shio andghuladze on 04.11.22.
//

import Foundation
import UIKit

class ButtonWithIcon: UIView{
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
        setUpIconImageView()
        setUpTextLabel()
        backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
    }
    
    func setText(text: String){
        textLabel.text = text
    }
    
    func setIcon(image: UIImage?){
        iconImageView.image = image
    }
    
    private func setUpIconImageView(){
        addSubview(iconImageView)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            iconImageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -20),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
        ])
    }
    
    private func setUpTextLabel(){
        addSubview(textLabel)
        
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        textLabel.font = .boldSystemFont(ofSize: 16)
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
}
