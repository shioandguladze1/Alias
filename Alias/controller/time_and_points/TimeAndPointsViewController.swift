//
//  TimeAndPointsViewController.swift
//  Alias
//
//  Created by shio andghuladze on 26.10.22.
//

import UIKit
import MTCircularSlider

class TimeAndPointsViewController: BaseViewController {
    private var arcadeButton: PaddingLabel?
    private var classicButton: PaddingLabel?
    private let game = Game.getInstance()
    
    private let timeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pointsValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeSliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeSlider: MTCircularSlider = {
        let seekBar = MTCircularSlider()
        seekBar.translatesAutoresizingMaskIntoConstraints = false
        return seekBar
    }()
    
    private let pointsSliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pointsSlider: MTCircularSlider = {
        let seekBar = MTCircularSlider()
        seekBar.translatesAutoresizingMaskIntoConstraints = false
        return seekBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalColorProvider.getColor(color: .nordDark).asUIColor()
        addGameModeObserver()
        setUpViews()
        setUpArcadeButton()
        setUpClassicButton()
        setUpTimeLabel()
        setUpTimeSlider()
        setUpPointsLabel()
        setUpPointsSlider()
        setUpTimeValueLabel()
        setUpPointsValueLabel()
    }
    
    private func setUpViews(){
        arcadeButton = getGameModeButton(forKey: classKey!, direction: .Right)
        classicButton = getGameModeButton(forKey: classKey!, direction: .Right)
        view.addSubview(arcadeButton!)
        view.addSubview(classicButton!)
    }
    
    private func setUpTimeValueLabel(){
        view.addSubview(timeValueLabel)
        
        timeValueLabel.textColor = GlobalColorProvider.getColor(color: .SecondWhite).asUIColor()
        timeValueLabel.font = .systemFont(ofSize: 20)
        timeValueLabel.sizeToFit()
        timeValueLabel.text = "60"
        
        NSLayoutConstraint.activate([
            timeValueLabel.centerXAnchor.constraint(equalTo: timeSlider.centerXAnchor),
            timeValueLabel.centerYAnchor.constraint(equalTo: timeSlider.centerYAnchor)
        ])
    }
    
    private func setUpPointsValueLabel(){
        view.addSubview(pointsValueLabel)
        
        pointsValueLabel.textColor = GlobalColorProvider.getColor(color: .SecondWhite).asUIColor()
        pointsValueLabel.font = .systemFont(ofSize: 20)
        pointsValueLabel.sizeToFit()
        pointsValueLabel.text = "30"
        
        NSLayoutConstraint.activate([
            pointsValueLabel.centerXAnchor.constraint(equalTo: pointsSlider.centerXAnchor),
            pointsValueLabel.centerYAnchor.constraint(equalTo: pointsSlider.centerYAnchor)
        ])
    }
    
    private func setUpPointsSlider(){
        let attributes = [
            Attributes.thumbRadius(9),
            Attributes.thumbTint(GlobalColorProvider.getColor(color: .darkBlue).asUIColor()),
            Attributes.minTrackTint(GlobalColorProvider.getColor(color: .darkBlue).asUIColor()),
            Attributes.maxTrackTint(GlobalColorProvider.getColor(color: .nordDark).asUIColor()),
            Attributes.trackWidth(12),
            Attributes.thumbShadowRadius(5)
        ]
        
        pointsSlider.applyAttributes(attributes)
        pointsSlider.addTarget(self, action: #selector(updateValue(_:)), for: .valueChanged)
        pointsSlider.valueMinimum = 5
        pointsSlider.valueMaximum = 100
        pointsSlider.value = 30
        pointsSlider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        view.addSubview(pointsSlider)
        
        NSLayoutConstraint.activate([
            pointsSlider.heightAnchor.constraint(equalToConstant: view.frame.height * 0.17),
            pointsSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pointsSlider.topAnchor.constraint(equalTo: pointsSliderLabel.bottomAnchor),
            pointsSlider.widthAnchor.constraint(equalTo: pointsSlider.heightAnchor)
        ])
    }
    
    private func setUpPointsLabel(){
        view.addSubview(pointsSliderLabel)
        
        pointsSliderLabel.textColor = .white
        pointsSliderLabel.font = .boldSystemFont(ofSize: 40)
        pointsSliderLabel.text = "Points"
        pointsSliderLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            pointsSliderLabel.topAnchor.constraint(equalTo: timeSlider.bottomAnchor),
            pointsSliderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpTimeLabel(){
        view.addSubview(timeSliderLabel)
        
        timeSliderLabel.textColor = .white
        timeSliderLabel.font = .boldSystemFont(ofSize: 40)
        timeSliderLabel.text = "Time"
        timeSliderLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            timeSliderLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: view.frame.height * 0.12),
            timeSliderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpTimeSlider(){
        let attributes = [
            Attributes.thumbRadius(9),
            Attributes.thumbTint(GlobalColorProvider.getColor(color: .darkBlue).asUIColor()),
            Attributes.minTrackTint(GlobalColorProvider.getColor(color: .darkBlue).asUIColor()),
            Attributes.maxTrackTint(GlobalColorProvider.getColor(color: .nordDark).asUIColor()),
            Attributes.trackWidth(12),
            Attributes.thumbShadowRadius(5)
        ]
        
        timeSlider.applyAttributes(attributes)
        timeSlider.valueMinimum = 5
        timeSlider.valueMaximum = 100
        timeSlider.value = 60
        timeSlider.tag = 1
        timeSlider.addTarget(self, action: #selector(updateValue(_:)), for: .valueChanged)
        timeSlider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        view.addSubview(timeSlider)
        
        NSLayoutConstraint.activate([
            timeSlider.heightAnchor.constraint(equalToConstant: view.frame.height * 0.17),
            timeSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeSlider.topAnchor.constraint(equalTo: timeSliderLabel.bottomAnchor),
            timeSlider.widthAnchor.constraint(equalTo: timeSlider.heightAnchor)
        ])
    }
    
    private func setUpArcadeButton(){
        if let arcadeButton = arcadeButton {
            arcadeButton.paddingRight = 72
            arcadeButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
            arcadeButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            arcadeButton.topAnchor.constraint(equalTo: classicButton!.bottomAnchor, constant: 8).isActive = true
            arcadeButton.text = "arcade".localized()
            arcadeButton.tag = 1
            arcadeButton.sizeToFit()
            arcadeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeGameMode(_:))))
            
            if game.gameMode == .Arcade {
                arcadeButton.backgroundColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
            }
        }
    }
    
    private func setUpClassicButton(){
        if let classicButton = classicButton {
            classicButton.paddingRight = 36
            classicButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
            classicButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            classicButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.7).isActive = true
            classicButton.text = "classic".localized()
            classicButton.tag = 0
            classicButton.sizeToFit()
            classicButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeGameMode(_:))))
            
            if game.gameMode == .Classic {
                classicButton.backgroundColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
            }
        }
     
    }
    
    @objc func updateValue(_ view: MTCircularSlider){
        let target = view.tag == 1 ? timeValueLabel : pointsValueLabel
        target.text = "\(Int(view.value))"
    }
    
    @objc func changeGameMode(_ sender: UITapGestureRecognizer? = nil){
        switch sender?.view?.tag{
        case 0:
            game.gameMode = .Classic
        case 1:
            game.gameMode = .Arcade
        default:
            break
        }
                
    }
    
    @objc private func changeButtonColors(){
        switch game.gameMode{
        case .Classic:
            classicButton?.backgroundColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
            arcadeButton?.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        case .Arcade:
            arcadeButton?.backgroundColor = GlobalColorProvider.getColor(color: .subtleGreen).asUIColor()
            classicButton?.backgroundColor = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
        default:
            return
        }
    }

    private func addGameModeObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(changeButtonColors), name: Game.notificationName, object: nil)
    }

}
