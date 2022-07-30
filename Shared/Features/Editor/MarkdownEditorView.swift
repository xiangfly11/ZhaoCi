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
            let codeBlock = setCodeBGBlock(with: .lightGray, html: html)
             return codeBlock
        }
        
        parser.addModifier(modifier)
        return parser.html(from: markdownText)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
              .foregroundColor(
                Color(UIColor.huaQing))
              .edgesIgnoringSafeArea(.top)
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
                }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                GeometryReader { proxy in
                    relayoutSubviews(height: proxy.size.height)
                }
            }
            
        }        
    }
    
    init() {
        UITextView.appearance().backgroundColor = UIColor.yunShuiLan
    }
}

extension MarkdownEditorView {
    func relayoutSubviews(height: CGFloat) -> some View {
        return VStack(alignment: .leading) {
            if selectedType == MarkdownEditorType.editor.rawValue {
                TextEditor(text: $markdownText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(height: height - 1)
            } else if selectedType == MarkdownEditorType.preview.rawValue {
                ZStack {
                    Rectangle()
                      .foregroundColor(Color(UIColor.yuDuBai))
                    iOSPreview(html: html)
                }.frame(height: height)
            } else if selectedType == MarkdownEditorType.split.rawValue {
                TextEditor(text: $markdownText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(height: height / 2)
                ZStack {
                    Rectangle()
                      .foregroundColor(Color(UIColor.yuDuBai))
                    iOSPreview(html: html)
                }.frame(height: height / 2)
            }
        }
    }
}

extension MarkdownEditorView {
    enum CodeBlockBGColor {
        case lightGray
        case darkGray
        case orange
        case blue
    }
    
    func setCodeBGBlock(with theme: CodeBlockBGColor = .lightGray, html: String) -> String {
        var bgColor = "<p style=\"background-color:rgb(211,211,211);\">"
        switch theme {
        case .lightGray:
            break;
        case .darkGray:
            bgColor = "<p style=\"background-color:rgb(47,79,79);\">"
        case .orange:
            bgColor = "<p style=\"background-color:rgb(255,165,0);\">"
        case .blue:
            bgColor = "<p style=\"background-color:rgb(135,206,235);\">"
        }
        
        let newCodeBlock1 = html.replacingOccurrences(of: "<code>", with: bgColor)
        let newCodeBlock2 = newCodeBlock1.replacingOccurrences(of: "</code>", with: "</p>")
        return newCodeBlock2
    }
}

struct MarkdownEditorView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownEditorView()
    }
}
