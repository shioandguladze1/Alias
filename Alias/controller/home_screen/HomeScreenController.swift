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
        setUpDropDown()
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
    
    @IBAction func showRules(_ sender: Any) {
        if let vcToPresent = storyboard?.instantiateViewController(withIdentifier: "RulesViewController"){
            vcToPresent.view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
            if let sheet = vcToPresent.sheetPresentationController{
                sheet.detents = [.medium(), .large()]
            }
            
            present(vcToPresent, animated: true)
        }
    }
    
    @IBAction func startGame(_ sender: Any) {
        navigationController?.pushViewController(PagerController(transitionStyle: .scroll, navigationOrientation: .horizontal), animated: true)
    }
    
    func setUpDropDown(){
        
        dropDown.isSearchEnable = false
        dropDown.text = "cur_lang".localized()
        dropDown.selectedRowColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        dropDown.checkMarkEnabled = false
        
        dropDown.didSelect { selectedText, index, id in
            switch index {
            case 0:
                changeLocalization(localization: .English)
            case 1:
                changeLocalization(localization: .Georgian)
            case 2:
                changeLocalization(localization: .Russian)
            default:
                break
            }
            
            self.showLoader()
        }
        
        dropDown.listDidDisappear {
            self.dropDown.text = "cur_lang".localized()
            self.stopLoader()
        }
                        
    }

    private func setUpPlayButton(){
        playButton.tintColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
    }
    
    private func setUpView(){
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
    }
    
    override func setTexts() {
        playButton.setTitle("start_game".localized(), for: .normal)
        dropDown.optionArray = ["lang_en".localized(), "lang_ge".localized(), "lang_ru".localized()]
    }
    
}
