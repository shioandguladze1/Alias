//
//  Color.swift
//  Alias
//
//  Created by shio andghuladze on 30.09.22.
//

import Foundation
import UIKit

fileprivate var appTheme: Theme = .Light

enum Theme {
    case Dark
    case Light
}

fileprivate protocol ColorProvider {
    var nordDark: CGColor { get }
    var subtleWhite: CGColor { get }
    var darkOutline: CGColor { get }
    var darkBlue: CGColor { get }
    var subtleRed: CGColor { get }
    var subtleGreen: CGColor { get }
    var SecondWhite: CGColor { get }
    var subtlePink: CGColor { get }
    var subtlePurple: CGColor { get }
}

enum AppColor {
    case nordDark
    case subtleWhite
    case darkOutline
    case darkBlue
    case subtleRed
    case subtleGreen
    case SecondWhite
    case subtlePink
    case subtlePurple
}

fileprivate class LightThemeColorProvider: ColorProvider {
    var nordDark: CGColor = CGColor(red: 46/255, green: 52/255, blue: 64/255, alpha: 1.0)
    
    var subtleWhite: CGColor = CGColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0)
    
    var darkOutline: CGColor = CGColor(red: 55/255, green: 63/255, blue: 71/255, alpha: 1.0)
    
    var darkBlue: CGColor = CGColor(red: 86/255, green: 100/255, blue: 128/255, alpha: 1.0)
    
    var subtleRed: CGColor = CGColor(red: 185/255, green: 81/255, blue: 91/255, alpha: 1.0)
    
    var subtleGreen: CGColor = CGColor(red: 121/255, green: 161/255, blue: 87/255, alpha: 1.0)
    
    var SecondWhite: CGColor = CGColor(red: 255/255, green: 236/255, blue: 240/255, alpha: 1.0)
    
    var subtlePink: CGColor = CGColor(red: 243/255, green: 94/255, blue: 84/255, alpha: 1)
    
    var subtlePurple: CGColor = CGColor(red: 146/255, green: 88/255, blue: 106/255, alpha: 1)
}

fileprivate class DarkThemeColorProvider {
    // MARK - implement when needed
}

class GlobalColorProvider{
    private static var colorProvider: ColorProvider = LightThemeColorProvider()
    
    static func changeAppTheme(theme: Theme){
        appTheme = theme
        switch theme {
            case .Dark: break;
            case .Light: colorProvider = LightThemeColorProvider();
        }
    }
    
    static func getColor(color: AppColor)-> CGColor{
        
        switch color {
        case .nordDark:
            return colorProvider.nordDark
        case .subtleWhite:
            return colorProvider.subtleWhite
        case .darkOutline:
            return colorProvider.darkOutline
        case .darkBlue:
            return colorProvider.darkBlue
        case .subtleRed:
            return colorProvider.subtleRed
        case .subtleGreen:
            return colorProvider.subtleGreen
        case .SecondWhite:
            return colorProvider.SecondWhite
        case .subtlePurple:
            return colorProvider.subtlePurple
        case .subtlePink:
            return colorProvider.subtlePink
        }
        
    }
    
}
