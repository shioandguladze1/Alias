//
//  TableViewAdapter.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import Foundation
import UIKit

class TableViewAdapter<T, C: TableViewAdapterCell>: NSObject, UITableViewDataSource, UITableViewDelegate{
    var data: [T] = []
    let tableView: UITableView
    let cellIdentifier: String
    let rowHeight: CGFloat
    var onCellClick: ((T)-> Void)?
    
    init(tableView: UITableView, cellIdentifier: String, rowHeight: CGFloat){
        self.tableView = tableView
        self.cellIdentifier = cellIdentifier
        self.rowHeight = rowHeight
        super.init()
        configureTableView()
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? C{
            cell.setUp(data: data[indexPath.row] as? C.T)
            return cell as? UITableViewCell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onCellClick?(data[indexPath.row])
    }
    
    func setData(data: [T]){
        self.data = data
        tableView.reloadData()
    }
    
}
