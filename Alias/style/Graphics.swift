//
//  Graphics.swift
//  Alias
//
//  Created by shio andghuladze on 03.10.22.
//

import Foundation
import UIKit

enum GradientDirection {
    case Horizontal
    case Vertical
}

extension UIView {
    
    func setGradientBackground(gradientDirection: GradientDirection, colors: [CGColor], type: CAGradientLayerType = .axial, locations: [NSNumber]? = nil){
        let gradient = CAGradientLayer()
        let startPoint: CGPoint
        let endPoint: CGPoint = CGPoint(x: 1, y: 1)
        
        gradient.colors = colors
        gradient.type = type
        gradient.frame = bounds
        gradient.locations = locations
        
        switch gradientDirection {
        case .Horizontal:
            startPoint = CGPoint(x: 0, y: 1)
        case .Vertical:
            startPoint = CGPoint(x: 1, y: 0)
        }
        
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint

        layer.insertSublayer(gradient, at: 0)
    }
    
    func makeOval(){
        let maxSize = max(frame.height, frame.width)
        layer.cornerRadius = maxSize / 2
        layer.sublayers?.forEach { $0.cornerRadius = maxSize / 2 }
    }
    
}





