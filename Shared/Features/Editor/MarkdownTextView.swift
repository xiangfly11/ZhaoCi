//
//  MarkdownTextView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/8/2.
//

import SwiftUI
import HighlightedTextEditor

struct MarkdownTextView: View {
    @Binding var markdownText: String
    @FocusState var focusedEditor: TextEditorType?
    var body: some View {
        HighlightedTextEditor(text: $markdownText, highlightRules: .customMarkdownRules)
            .configMarkdownToolbar()
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .background(Color(UIColor.yunShuiLan))
            .focused($focusedEditor, equals: .contentType)
            .onSubmit {
                focusedEditor = nil
            }
            .submitLabel(.done)
    }
}

struct MarkdownTextView_Previews: PreviewProvider {
    @State static var markdownText: String = ""
    static var previews: some View {
        MarkdownTextView(markdownText: $markdownText)
    }
}
