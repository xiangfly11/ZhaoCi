//
//  RZRichTextViewOptions.swift
//  CMRichTextView
//
//  Created by rztime on 2021/10/15.
//

import UIKit
import Photos

// 输入键盘上的工具条
@objc public enum CMTextViewToolbarItem : NSInteger {
    case endEdit = -1
    case cimage = 0
    case cfont = 1
    case cvideo = 2
    case clink = 3 
}

/// 配置工具条，及相关的属性功能
@objcMembers
open class CMRichTextViewOptions: NSObject {
    
    public enum FontStyleItem: Int {
        case bold = 0
        case itial = 1
        case underLine = 2
        case deleteLine = 3
    }
    /// 默认使用单例
    public static var shared: CMRichTextViewOptions = .init()
    
    /// 正常字体
    open var normalFont: UIFont = .systemFont(ofSize: 16)
    /// 粗体
    open var boldFont: UIFont = .boldSystemFont(ofSize: 16)
    /// 是否支持(有序、无序)列表功能，当支持时，在changeRaneg, text改变时，将会在列表文本处理一些复杂任务，比如增删序号
    /// 如果为false，需要移除toolbarItems里的CMTextViewToolbarItem.tabStyle的item
    open var enableTabStyle = true
    /// 在输入的时候，是否删除textView.typingAttributes里的link属性，默认为true, 输入时无link属性
    /// false时，光标在link之外的地方，或者范围过界，则无link，也就是可以直接修改link的文本
    open var shouldRemoveLinkWhenEditing = false
    
    /// 上传时进度条的颜色
    open var uploadProgressColor = UIColor.init(red: 1, green: 70/255.0, blue: 70/255.0, alpha: 1)
    ///  rgba 设定可选颜色 
    open var colors: [RZRichColor] = [
        .init(161, 161, 161, 1),
        .init(117, 117, 117, 1),
        .init(25, 25, 25, 1),
        .init(255, 246, 0, 1),
        .init(255, 0, 0, 1),
        .init(3, 132, 225, 1),
        .init(0, 236, 28, 1),
        .init(120, 0, 255, 1),
    ]
    open var fontsizes : [CGFloat] = [12, 16, 18, 20]
    /// 可以自行修改图片
    open var imageIcon = CMRichTextImage.imageWith(name: "rt_imageIcon")
    open var fontIcon = CMRichTextImage.imageWith(name: "rt_fontStyleIcon")
    open var fontHightIcon = CMRichTextImage.imageWith(name: "rt_fontStyleIcon_hight")
    open var videoIcon = CMRichTextImage.imageWith(name: "rt_videoIcon")
    open var linkIcon = CMRichTextImage.imageWith(name: "rt_linkIcon")
    open var revokeIcon = CMRichTextImage.imageWith(name: "rt_revokeIcon")
    open var reStoreIcon = CMRichTextImage.imageWith(name: "rt_restoreIcon")
    open var boldIcon = CMRichTextImage.imageWith(name: "rt_boldIcon")
    open var itialIcon = CMRichTextImage.imageWith(name: "rt_itailIcon")
    open var underLineIcon = CMRichTextImage.imageWith(name: "rt_underLineIcon")
    open var deleteLineIcon = CMRichTextImage.imageWith(name: "rt_deleteLineIcon")
    open var aliginDefaultIcon = CMRichTextImage.imageWith(name: "rt_aligin_default")
    open var aliginLeftIcon = CMRichTextImage.imageWith(name: "rt_aliginLeftIcon")
    open var aliginCenterIcon = CMRichTextImage.imageWith(name: "rt_aliginCenterIcon")
    open var aliginrightIcon = CMRichTextImage.imageWith(name: "rt_aliginRightIcon")
    open var deleteIcon = CMRichTextImage.imageWith(name: "rt_deleteIcon")
    open var playIcon = CMRichTextImage.imageWith(name: "rt_playicon")
    open var saveToDraftIcon = CMRichTextImage.imageWith(name: "rt_saveToDart")
    open var addCoverIcon = CMRichTextImage.imageWith(name: "rt_addCover")
    open var changeCoverIcon = CMRichTextImage.imageWith(name: "rt_changeCover")
    open var changeVideoIcon = CMRichTextImage.imageWith(name: "rt_changeVideo")
    /// 键盘上显示的工具条条目
    open lazy var toolbarItems: [CMToolBarItem] = [
//        .init(type: CMTextViewToolbarItem.cimage.rawValue, image: imageIcon, selectedImage: nil, selected: false, exparams: nil, items: nil),
//        .init(type: CMTextViewToolbarItem.cfont.rawValue, image: fontIcon, selectedImage: fontHightIcon, selected: false, exparams: nil, items: nil),
//        .init(type: CMTextViewToolbarItem.cvideo.rawValue, image: videoIcon, selectedImage: nil, selected: false, exparams: nil, items: nil),
//        .init(type: CMTextViewToolbarItem.clink.rawValue, image: linkIcon, selectedImage: nil, selected: false, exparams: nil, items: nil),
        .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "H1", selected: false,exparams: nil, items: nil),
        .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "H2", selected: false,exparams: nil, items: nil),
        .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "H3", selected: false,exparams: nil, items: nil),
        .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "```", selected: false,exparams: nil, items: nil),
        .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "<", selected: false,exparams: nil, items: nil),
        .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "**", selected: false,exparams: nil, items: nil),
        .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: ">", selected: false,exparams: nil, items: nil),
    ]

    public override init () {
        super.init()
    }
    /// 工具条要自定义时，可以注册cell identifier
    open var willRegisterAccessoryViewCell: ((UICollectionView) -> Void)?
    /// 键盘上的工具条cell，如果不需要自定义，就不用设置，或者返回nil
    open var accessoryViewCellFor:((UICollectionView, CMToolBarItem, IndexPath) -> UICollectionViewCell?)?
    
    /// 点击了toolbar上的item，return false时，即需自行实现点击事件。。。 默认 return true
    open var didSelectedToolbarItem: ((_ item: CMToolBarItem, _ index: Int) -> Bool)?
    
    /// 将要插入图片时，可对图片进行预处理，然后返回图片
    open var willInsetImage:((UIImage) -> UIImage?)?
    
    /// 插入了一个附件（图片，PHAsset， 视频，等等，可以在maskView上处理一些UI和上传等等操作）
    open var didInsetAttachment:((NSTextAttachment) -> Void)?
    /// 删除了附件之后将会回调
    open var didRemovedAttachment:(([NSTextAttachment]) -> Void)?
    /// 打开相册，去选择图片或者视频,完成之后，返回图片，如果有PHAsset，就返回，图片必须要有，否则无法添加进textView
    open var openPhotoLibrary:((_ complete:@escaping((UIImage?, PHAsset?) -> Void)) -> Void)?
}

public class CMRichTextImage {
    public class func imageWith(name: String) -> UIImage? {
        let bundle = Bundle.init(for: CMRichTextImage.self)
        guard let url = bundle.url(forResource: "CMRichTextView", withExtension: "bundle") else {
            return nil
        }
        let imagebundle = Bundle.init(url: url)
        
        let fileName = "\(name)@3x"
        var imagePath = imagebundle?.path(forResource: fileName, ofType: "png")
        if let imagePath = imagePath {
            return UIImage.init(contentsOfFile: imagePath)
        }
        imagePath = imagebundle?.path(forResource: "CMRichTextView.bundle/\(fileName)", ofType: "png")
        if let imagePath = imagePath {
            return .init(contentsOfFile: imagePath)
        }
        return nil
    }
}
@objcMembers
open class RZRichColor: NSObject {
    open var r: CGFloat = 0
    open var g: CGFloat = 0
    open var b: CGFloat = 0
    open var a: CGFloat = 0
    public init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
    open var color: UIColor {
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
