//
//  HighlightedTextEditorExt.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/8/3.
//

import Foundation
import UIKit
import SwiftUI
import HighlightedTextEditor

extension HighlightedTextEditor {
    
    public var markdownOptions: CMRichTextViewOptions {
        let options = CMRichTextViewOptions.init()
        return options
    }
    
    public var markdownItems: [CMToolBarItem] {
        return [
            .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "H1", selected: false,exparams: nil, items: nil),
            .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "H2", selected: false,exparams: nil, items: nil),
            .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "H3", selected: false,exparams: nil, items: nil),
            .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "```", selected: false,exparams: nil, items: nil),
            .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "<", selected: false,exparams: nil, items: nil),
            .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: "**", selected: false,exparams: nil, items: nil),
            .init(type: CMTextViewToolbarItem.cimage.rawValue, image: nil, selectedImage: nil, textSymbol: ">", selected: false,exparams: nil, items: nil),
        ]
        
    }
    
    func configMarkdownToolbar() -> HighlightedTextEditor {
       return self.introspect { editor in
           self.markdownOptions.toolbarItems = markdownItems
            editor.textView.inputAccessoryView = MarkdownInputAccessoryView.init(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44), options: self.markdownOptions)
        }
    }
}
