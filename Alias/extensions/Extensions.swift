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

extension UIViewController {
    
    func showAlertWithOkButton(title: String, body: String){
        let dialogMessage = UIAlertController(title: title, message: body, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default){_ in
            dialogMessage.dismiss(animated: true)
        }
        
        dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
    }
    
}

extension Optional where Wrapped == String {
    
    func ifNotNullOrEmpty(defaultValue: String = "")-> String{
        
        if self?.isEmpty == true || self == nil{
            return defaultValue
        }
        
        return self!
        
    }
    
}
