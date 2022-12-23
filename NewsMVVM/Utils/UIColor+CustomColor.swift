//
//  UIColor+CustomColor.swift
//  NewsMVVM
//
//  Created by Ali Akbar on 23/12/22.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    
    static let AppNavBarColor = UIColor(rgb: 0x30336b)
    static let AppNavBarTitleTextColor = UIColor(rgb: 0xdff9fb)
    static let AppNavbarLargeTitleTextColor = UIColor(rgb: 0x30336b)
}
