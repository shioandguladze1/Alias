//
//  RulesViewController.swift
//  Alias
//
//  Created by shio andghuladze on 04.10.22.
//

import UIKit

class RulesViewController: UIViewController {
    @IBOutlet weak var rulesTableView: UITableView!
    private var adapter: TableViewAdapter<Rule, RulesTableViewCell>?

    override func viewDidLoad() {
        super.viewDidLoad()
        rulesTableView.separatorStyle = .none
        rulesTableView.allowsSelection = false
        adapter = TableViewAdapter(tableView: rulesTableView, cellIdentifier: "RulesTableViewCell", rowHeight: UITableView.automaticDimension)
        
        adapter?.setData(data: [
            Rule(title: "rules_divide_by_teams".localized(), firstDescription: "rules_second".localized(), secondDescription: "rules_third".localized()),
            Rule(title: "rules_fourth".localized(), firstDescription: "rules_fifth".localized(), secondDescription: "rules_sixth".localized()),
            Rule(title: "rules_seventh".localized(), firstDescription: "rules_eighth".localized(), secondDescription: "rules_ninth".localized()),
            Rule(title: "rules_tenth".localized(), firstDescription: "rules_eleventh".localized(), secondDescription: "rules_twelveth".localized()),
            Rule(title: "rules_thirteenth".localized(), firstDescription: "rules_fourteenth".localized(), secondDescription: nil)
        ])
    }

}
