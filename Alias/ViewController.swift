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
        
        let c1 = GameModeViewController()
        let c2 = TeamsViewController()
        
        controllers = [c1, c2]
        
        setViewControllers([c1], direction: .forward, animated: true)
        
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
