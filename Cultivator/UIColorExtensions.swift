//
//  UIColorExtensions.swift
//  Time
//
//  Created by Julian Abentheuer on 11.12.14.
//  Copyright (c) 2014 Aaron Abentheuer. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    //iOS System Colors as of iOS 8.0 based on "Teehan+Lax" iOS8-Screendesign Template for Sketch.
    class func systemStandardBackgroundColor (alpha : CGFloat = 1.0) -> UIColor {return UIColor(hex: 0xEFEFF4, alpha: alpha)}
    class func systemStandardLabelBlueColor (alpha : CGFloat = 1.0) -> UIColor {return UIColor(hex: 0x037AFF, alpha: alpha)}
    class func systemStandardSignalGreenColor (alpha : CGFloat = 1.0) -> UIColor {return UIColor(hex: 0x4CD864, alpha: alpha)}
    class func systemStandardSignalRedColor (alpha : CGFloat = 1.0) -> UIColor {return UIColor(hex: 0xFF3B30, alpha: alpha)}
    
    //Application specific colors free to customize based on Screendesigns.
    class func applicationDayGloOrange (alpha : CGFloat = 1.0) -> UIColor {return UIColor(hex: 0xff2300, alpha: alpha)}
}