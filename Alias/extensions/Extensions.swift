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
    
    func setChildImageViewImage(image: UIImage){
        subviews.forEach { view in
            (view as? UIImageView)?.image = image
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
    
    func showBottomSheetview(height: CGFloat, bottomView: UIView, footerView: UIView? = nil, footerHeight: CGFloat = 0)-> UIViewController{
        let bottomSheetController = UIViewController()
        bottomSheetController.view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        var bottomAnchor = bottomSheetController.view.bottomAnchor
        if let footerView = footerView {
            bottomSheetController.view.addSubview(footerView)
            bottomAnchor = footerView.topAnchor
            footerView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                footerView.bottomAnchor.constraint(equalTo: bottomSheetController.view.bottomAnchor),
                footerView.widthAnchor.constraint(equalTo: bottomSheetController.view.widthAnchor),
                footerView.heightAnchor.constraint(equalToConstant: footerHeight)
            ])
        }
        
        NSLayoutConstraint.activate([
            bottomView.widthAnchor.constraint(equalTo: bottomSheetController.view.widthAnchor),
            bottomView.topAnchor.constraint(equalTo: bottomSheetController.view.topAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        bottomSheetController.preferredContentSize.height = height + footerHeight
        presentBottomSheet(viewController: bottomSheetController, configuration: .default)
        return bottomSheetController
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
