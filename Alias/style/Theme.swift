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
}

enum AppColor {
    case nordDark
    case subtleWhite
    case darkOutline
    case darkBlue
    case subtleRed
    case subtleGreen
    case SecondWhite
}

fileprivate class LightThemeColorProvider: ColorProvider {
    var nordDark: CGColor = CGColor(red: 46, green: 52, blue: 64, alpha: 1.0)
    
    var subtleWhite: CGColor = CGColor(red: 221, green: 221, blue: 221, alpha: 1.0)
    
    var darkOutline: CGColor = CGColor(red: 55, green: 63, blue: 71, alpha: 1.0)
    
    var darkBlue: CGColor = CGColor(red: 86, green: 100, blue: 128, alpha: 1.0)
    
    var subtleRed: CGColor = CGColor(red: 185, green: 81, blue: 91, alpha: 1.0)
    
    var subtleGreen: CGColor = CGColor(red: 121, green: 161, blue: 87, alpha: 1.0)
    
    var SecondWhite: CGColor = CGColor(red: 255, green: 236, blue: 240, alpha: 1.0)
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
        }
        
    }
    
}
