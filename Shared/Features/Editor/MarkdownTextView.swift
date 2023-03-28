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
    @Binding var title: String
    @FocusState var focusedEditor: TextEditorType?
    var body: some View {
        VStack {
            TextField("标题", text: $title)
                .textFieldStyle(.roundedBorder)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .font(Font.WenKaiMonoBold(size: 16))
            HighlightedTextEditor(text: $markdownText, highlightRules: .customMarkdownRules)
                .configMarkdownToolbar()
                .onTextChange()
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .focused($focusedEditor, equals: .contentType)
                .onSubmit {
                    focusedEditor = nil
                }
            .submitLabel(.done)
        }
        .background(Color(uiColor: UIColor.clear))
    }
}

struct MarkdownTextView_Previews: PreviewProvider {
    @State static var markdownText: String = ""
    static var previews: some View {
        MarkdownTextView(markdownText: $markdownText, title: .constant(""))
    }
}

