//
//  RZToolBarItem.swift
//  CMRichTextView
//
//  Created by rztime on 2021/10/15.
//

import UIKit

@objcMembers
open class CMToolBarItem: NSObject {
    open var type: Int = 0
    open var image: UIImage?
    open var selectedImage: UIImage?
    open var selected: Bool = false
    
    /// 扩展的其他参数，有需要时，可使用
    open var exParams: Any?
    /// 参考RZTextViewFontStyle的值
    open var items: [NSInteger]?
    
    /// markdown按钮显示的文案
    open var textSymbol: String?
    /// markdown字符
    open var textStr: String?
    
    /// 初始化类型
    /// - Parameters:
    ///   - type: CMTextViewToolbarItem 参考，可自行设置
    ///   - image: 默认图片
    ///   - selectedImage: 选中时的图片
    ///   - selected: 选中
    ///   - exparams: 附带的额外的参数
    public init(type: Int, image: UIImage? = nil, selectedImage: UIImage? = nil, textSymbol: String? = nil, textStr: String? = nil, selected: Bool = false, exparams: Any? = nil, items: [NSInteger]? = nil) {
        super.init()
        self.type = type
        self.image = image
        self.selectedImage = selectedImage
        self.selected = selected
        self.exParams = exparams
        self.items = items
        self.textSymbol = textSymbol
        self.textStr = textStr
    }
    /// 需要显示的图片
    open func displayImage() -> UIImage? {
        if selected {
            return selectedImage ?? image
        }
        return image
    }
}
