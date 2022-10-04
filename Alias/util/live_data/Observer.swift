//
//  Observer.swift
//  Alias
//
//  Created by shio andghuladze on 03.10.22.
//

import Foundation

struct Observer<T>: Hashable{
    let block: (T)-> Void
    let id = Int.random(in: 0...Int.max)
    
    static func == (lhs: Observer<T>, rhs: Observer<T>) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
