//
//  UIColorExt.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/30.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    open class var bingShanLan: UIColor {
        return UIColor.colorFromHex(hexValue: 0xa4aca7)
        
    }
    
    open class var chenXiHong: UIColor {
        return UIColor.colorFromHex(hexValue: 0xea8958)
    }
    
    open class var lianZiBai: UIColor {
        return UIColor.colorFromHex(hexValue: 0xe5d3aa)
    }
    
    open class var bengRouBai: UIColor {
        return UIColor.colorFromHex(hexValue: 0xf9f1db)
    }
    
    static func colorFromHex(hexValue: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
               red: CGFloat((Float((hexValue & 0xff0000) >> 16)) / 255.0),
               green: CGFloat((Float((hexValue & 0x00ff00) >> 8)) / 255.0),
               blue: CGFloat((Float((hexValue & 0x0000ff) >> 0)) / 255.0),
               alpha: alpha)
    }
}
