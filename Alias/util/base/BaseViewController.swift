//
//  BaseViewController.swift
//  Alias
//
//  Created by shio andghuladze on 03.10.22.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    private var observer: Observer<Localization>?
    var classKey: String?
    
    var isBackNavigationEnabled: Bool { true }
    
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
    
    private var backGestureRecognizer: UIScreenEdgePanGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        classKey = String(describing: self)
        setUpBackGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observer = Observer{_ in self.setTexts() }
        localizationLiveData.addObserver(observer: observer!)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        localizationLiveData.removeObserver(observer: observer!)
    }
    
    private func setUpBackGestureRecognizer(){
        if !isBackNavigationEnabled {
            return
        }
        
        backGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onBackPressed(sender:)))
        backGestureRecognizer!.edges = .left
        view.addGestureRecognizer(backGestureRecognizer!)
    }
    
    func setTexts(){
        
    }
    
    @objc func onBackPressed(sender: UIScreenEdgePanGestureRecognizer){
        if sender.state == .ended {
            
            if navigationController?.viewControllers.count ?? 0 > 1 {
                navigationController?.popViewController(animated: true)
            }
            
        }
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearObservations(forKey: classKey)
    }
}
