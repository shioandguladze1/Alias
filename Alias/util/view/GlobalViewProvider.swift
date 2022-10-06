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

func clearObservations(forKey: String?){
    if let key = forKey {
        observers[key]?.forEach{ $0.invalidate() }
        observers.removeValue(forKey: key)
    }
}
