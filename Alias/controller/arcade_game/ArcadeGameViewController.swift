//
//  ArcadeGameViewController.swift
//  Alias
//
//  Created by shio andghuladze on 31.10.22.
//

import UIKit

class ArcadeGameViewController: BaseGameViewController {
    
    private let wordView: OptionsLabel = {
        let view = OptionsLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWordView()
    }
    
    private func setUpWordView(){
        view.addSubview(wordView)
        
        wordView.setText(text: "asdasdasd")
        wordView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            wordView.topAnchor.constraint(equalTo: countDownTimerView.bottomAnchor, constant: 32),
            wordView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 64),
            wordView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -64),
            wordView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
