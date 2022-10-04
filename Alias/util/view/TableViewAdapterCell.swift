//
//  TableViewAdapterCell.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import Foundation

protocol TableViewAdapterCell{
        
    associatedtype T
    
    func setUp(data: T?)
    
}
