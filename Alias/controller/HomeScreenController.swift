//
//  HomeScreenController.swift
//  Alias
//
//  Created by shio andghuladze on 03.10.22.
//

import UIKit
import iOSDropDown

class HomeScreenController: BaseViewController {
    @IBOutlet weak var appNameBackgroundView: UIView!
    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var dropDown: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAppNameView()
        setUpView()
        setUpPlayButton()
    }
    
    
    private func setUpAppNameView(){
        appNameBackgroundView.setGradientBackground(
            gradientDirection: .Horizontal,
            colors: [
                GlobalColorProvider.getColor(color: .subtlePurple),
                GlobalColorProvider.getColor(color: .subtlePink)
            ],
            locations: [0.4]
        )
        
        appNameBackgroundView.makeOval()
        appNameBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.3).isActive = true
    }

    private func setUpPlayButton(){
        playButton.tintColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
    }
    
    private func setUpView(){
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
    }
    
    override func setTexts() {
        playButton.setTitle("start_game".localized(), for: .normal)
    }
    
}
