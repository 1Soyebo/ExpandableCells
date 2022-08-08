//
//  Color+Extensions.swift
//  ExpandableTest
//
//  Created by Ibukunoluwa Soyebo on 08/08/2022.
//

import UIKit

//MARK:- UIColor  Extension
extension UIColor{
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        guard cString.count == 6 else {
            self.init(white: 0.5, alpha: 1)
            return
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0)
        )
    }
    
    
    static var gradientDarkGrey: UIColor{
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }
    
    static var gradientLightGrey: UIColor{
        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }
    

}
