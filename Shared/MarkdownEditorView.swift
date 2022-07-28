//
//  MarkdownEditorView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/28.
//

import SwiftUI
import Ink

struct MarkdownEditorView: View {
    @State private var markdownText: String = ""
    @State private var selectedType: Int = MarkdownEditorType.editor.rawValue
    var html: String {
        var parser = MarkdownParser()
        let modifier = Modifier(target: .codeBlocks) { html, markdown in
            return "<h3>This is code block:</h3>" + html
        }
        
        parser.addModifier(modifier)
        return parser.html(from: markdownText)
    }
    var body: some View {
        VStack {
            HStack {
                Text("Markdown Editor")
                    .font(.title2)
                    .fontWeight(.medium)
                Picker("", selection: $selectedType) {
                    ForEach(MarkdownEditorType.allCases) { type in
                        Text(type.markdownEditorTypeName)
                            .tag(type.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
            }
            GeometryReader { proxy in
                relayoutSubviews(height: proxy.size.height)
            }
        }.padding()
    }
    
    init() {
        UITextView.appearance().backgroundColor = .darkGray
    }
}

extension MarkdownEditorView {
    func relayoutSubviews(height: CGFloat) -> some View {
        return VStack(alignment: .leading) {
            if selectedType == MarkdownEditorType.editor.rawValue {
                TextEditor(text: $markdownText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(height: height)
            } else if selectedType == MarkdownEditorType.preview.rawValue {
                ZStack {
                    Rectangle()
                      .frame(height: height)
                      .foregroundColor(.secondary)
                    iOSPreview(html: html)
                        .frame(height: height)
                }.frame(height: height)
            } else if selectedType == MarkdownEditorType.split.rawValue {
                TextEditor(text: $markdownText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(height: height / 2)
                Divider()
                ZStack {
                    Rectangle()
                      .frame(height: height / 2)
                      .foregroundColor(.secondary)
                    iOSPreview(html: html)
                        .frame(height: height / 2)
                }.frame(height: height / 2)
            }
        }
    }
}

struct MarkdownEditorView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownEditorView()
    }
}
