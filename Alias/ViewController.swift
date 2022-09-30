//
//  ViewController.swift
//  Alias
//
//  Created by shio andghuladze on 29.09.22.
//

import UIKit
import SQLite3

class ViewController: UIPageViewController {
    private var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        let c1 = UIViewController()
        c1.view.backgroundColor = .red
        
        let c2 = UIViewController()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.type = .axial
        gradient.frame = c2.view.bounds
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        c2.view.layer.addSublayer(gradient)
        
        changeLocalization(localization: .English)
        print("Welcome".localized())
        
        let c3 = UIViewController()
        c3.view.backgroundColor = .cyan
        
        controllers = [c1, c2, c3]
        
        setViewControllers([c2], direction: .forward, animated: true)
    }


    
}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
 
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = controllers.firstIndex(of: viewController) ?? -1
        if index > 0 {
            return controllers[index - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = controllers.firstIndex(of: viewController) ?? controllers.count
        if index < controllers.count - 1 {
            return controllers[index + 1]
        }
        return nil
    }
    
}
