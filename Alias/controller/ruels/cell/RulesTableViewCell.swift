//
//  RulesTableViewCell.swift
//  Alias
//
//  Created by shio andghuladze on 04.10.22.
//

import UIKit

class RulesTableViewCell: UITableViewCell, TableViewAdapterCell {
    typealias T = Rule
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstDescriptionLabel: UILabel!
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    
    func setUp(data: Rule?) {
        titleLabel.text = data?.title
        firstDescriptionLabel.text = data?.firstDescription
        secondDescriptionLabel.text = data?.secondDescription
    }
}
