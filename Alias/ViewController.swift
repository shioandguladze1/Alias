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
        let textview = UITextView()
        textview.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.textColor = .white
        textview.backgroundColor = .brown
        c2.view.addSubview(textview)
        textview.center = c2.view.center
        
        DispatchQueue.main.async {
            sleep(3)
            changeLocalization(localization: .Russian)
        }
        
            
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
