//
//  Extensions.swift
//  Alias
//
//  Created by shio andghuladze on 30.09.22.
//

import Foundation
import UIKit

extension CGColor {
    
    func asUIColor()-> UIColor{
        UIColor(cgColor: self)
    }
    
}

extension UIView {
    
    func hideWithFade(duration: TimeInterval = 1.0){
        UIView.animate(withDuration: duration) {
            self.layer.opacity = 0
        } completion: { completed in
            if completed {
                self.isHidden = true
            }
        }
    }
    
}

