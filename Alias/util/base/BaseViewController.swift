//
//  BaseViewController.swift
//  Alias
//
//  Created by shio andghuladze on 03.10.22.
//

import UIKit

class BaseViewController: UIViewController {
    private var observer: Observer<Localization>?

    override func viewDidLoad() {
        super.viewDidLoad()
        observer = Observer{_ in self.setTexts() }
        localizationLiveData.addObserver(observer: observer!)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        localizationLiveData.removeObserver(observer: observer!)
    }
    
    func setTexts(){
        
    }

}
