//
//  InputToolBarItem.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/8/3.
//

import Foundation
import UIKit

struct InputToolBarItem {
    public var type: Int = 0
    public var image: UIImage?
    public var selectedImage: UIImage?
    public var selected: Bool = false
    
    /// 扩展的其他参数，有需要时，可使用
    public var exParams: Any?
    
    public var items: [NSInteger]?
    
    /// 需要显示的图片
    public func displayImage() -> UIImage? {
        if selected {
            return selectedImage ?? image
        }
        return image
    }
}
