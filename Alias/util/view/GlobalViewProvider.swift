//
//  GlobalViewProvider.swift
//  Alias
//
//  Created by shio andghuladze on 06.10.22.
//

import Foundation
import UIKit

private var observers = [String: [NSKeyValueObservation]]()

enum Direction{
    case Left
    case Right
}

func getGameModeButton(forKey: String, direction: Direction)-> PaddingLabel{
    let label = PaddingLabel()
    label.font = .systemFont(ofSize: 30, weight: .heavy)
    label.textColor = .white
    label.clipsToBounds = true
    label.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isUserInteractionEnabled = true
    
    
    let observation = label.layer.observe(\.bounds){obj, _ in
        label.layer.cornerRadius = obj.bounds.height / 2
    }
    
    var observersForKey = observers[forKey] ?? []
    observersForKey.append(observation)
    observers[forKey] = observersForKey
    
    switch direction {
    case .Left:
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        label.textAlignment = .right
        label.paddingRight = 8
    case .Right:
        label.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        label.textAlignment = .left
        label.paddingLeft = 8
    }
    
    return label
}

func getRoundButtonWithIcon(size: Int, padding: CGFloat, iconName: String)-> UIButton {
    let button = UIButton()
    button.frame = CGRect(x: 0, y: 0, width: size, height: size)
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: iconName)
    button.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        imageView.widthAnchor.constraint(equalTo: button.widthAnchor, constant: -padding),
        imageView.heightAnchor.constraint(equalTo: button.heightAnchor, constant: -padding),
        imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
    ])
    
    imageView.tintColor = .white
    imageView.contentMode = .scaleAspectFit
    button.layer.cornerRadius = CGFloat(size / 2)
    button.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
    button.clipsToBounds = true
    return button
}

func getTeamTextField(id: Int)-> UITextField{
    let teamTextField = UITextField()
    teamTextField.layer.cornerRadius = 26
    teamTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    teamTextField.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
    teamTextField.clipsToBounds = true
    teamTextField.translatesAutoresizingMaskIntoConstraints = false
    teamTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    teamTextField.textColor = .white
    teamTextField.font = .systemFont(ofSize: 28)
    
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
    teamTextField.leftView = paddingView
    teamTextField.leftViewMode = .always
    
    teamTextField.text = "Team\(id)"
    return teamTextField
}

func clearObservations(forKey: String?){
    if let key = forKey {
        observers[key]?.forEach{ $0.invalidate() }
        observers.removeValue(forKey: key)
    }
}
