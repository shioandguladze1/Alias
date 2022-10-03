//
//  Observable.swift
//  Alias
//
//  Created by shio andghuladze on 03.10.22.
//

import Foundation

protocol Observable{
    
    associatedtype T
    
    func addObserver(observer: Observer<T>)
    
    func removeObserver(observer: Observer<T>)
    
    func notifyObservers()
    
}
