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
    
    func configMarkdownToolbar() -> HighlightedTextEditor {
       return self.introspect { editor in
           let accessoryView = MarkdownInputAccessoryView.init(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44), options: CMRichTextViewOptions.shared)
           editor.textView.inputAccessoryView = accessoryView
           accessoryView.didSelected = { (item, index) in
               let currentText = editor.textView.text
               let appendedText = currentText?.appending(item.textStr ?? "")
               editor.textView.text = appendedText
               EditorRecord.shared.pushContent(text: appendedText ?? "")
           }
        }
    }
    
    func onTextChange() -> HighlightedTextEditor {
        return self.onTextChange({ editorContent in
            EditorRecord.shared.pushContent(text: editorContent)
        })
    }
}
