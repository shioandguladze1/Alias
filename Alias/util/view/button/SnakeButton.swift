//
//  SnakeButton.swift
//  Alias
//
//  Created by shio andghuladze on 07.10.22.
//

import Foundation
import UIKit

class SnakeButton: UIView{
    private var color = GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
    private var lineHeight = CGFloat(13)
    var isActive = false {
        didSet{
            color = isActive ? GlobalColorProvider.getColor(color: .subtleGreen).asUIColor() : GlobalColorProvider.getColor(color: .darkBlue).asUIColor()
            setNeedsDisplay()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        let radius = frame.height / 2
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addArc(withCenter: CGPoint(x: 0, y: radius), radius: radius, startAngle: -90, endAngle: 90, clockwise: true)
        
        path.move(to: CGPoint(x: frame.width, y: 0))
        
        path.addArc(withCenter: CGPoint(x: frame.width, y: radius), radius: radius, startAngle: 90, endAngle: 270, clockwise: true)
        
        path.move(to: CGPoint(x: 0, y: radius - lineHeight / 2))
        
        path.addLine(to: CGPoint(x: frame.width, y: radius - lineHeight / 2))
        
        path.addLine(to: CGPoint(x: frame.width, y: radius + lineHeight / 2))
        
        path.addLine(to: CGPoint(x: 0, y: radius + lineHeight / 2))
        
        path.close()
        color.set()
        path.fill()
    }
    
    func setLineHeight(lineHeight: CGFloat){
        self.lineHeight = lineHeight
        setNeedsDisplay()
    }
    
    
    
}
