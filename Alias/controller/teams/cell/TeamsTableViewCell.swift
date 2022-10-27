//
//  TeamsTableViewCell.swift
//  Alias
//
//  Created by shio andghuladze on 21.10.22.
//

import UIKit

class TeamsTableViewCell: UITableViewCell, TableViewAdapterCell {
    @IBOutlet weak var teamTextField: UITextField!
    private var id: Int?
    
    typealias T = Int
    
    func setUp(data: Int?) {
        if let data = data { teamTextField.text = "Team\(data)" }
        id = data
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTextField()
        backgroundColor = .clear
        transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
    private func setUpTextField(){
        teamTextField.layer.cornerRadius = 26
        teamTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        teamTextField.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        teamTextField.clipsToBounds = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        teamTextField.leftView = paddingView
        teamTextField.leftViewMode = .always
    }
    
    func getTeamName()-> String{
        teamTextField.text ?? ""
    }
    
    func getId()-> Int {
        id ?? -1
    }
}
