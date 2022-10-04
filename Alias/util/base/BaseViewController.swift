//
//  BaseViewController.swift
//  Alias
//
//  Created by shio andghuladze on 03.10.22.
//

import UIKit

class BaseViewController: UIViewController {
    private var observer: Observer<Localization>?
    
    private let loaderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        return view
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.hidesWhenStopped = true
        view.color = .white
        return view
    }()

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
    
    func showLoader(){
        loaderView.bounds = self.view.frame
        loaderView.center = self.view.center
        indicatorView.center = view.center
        indicatorView.startAnimating()
        self.view.addSubview(loaderView)
        self.view.addSubview(indicatorView)
    }

    func stopLoader(){
        loaderView.removeFromSuperview()
        indicatorView.stopAnimating()
        indicatorView.removeFromSuperview()
    }
}
