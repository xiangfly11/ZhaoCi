//
//  MarkdownEditorView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/28.
//

import SwiftUI

struct MarkdownEditorView: View {
    @State private var markdownText: String = ""
    var markdown: AttributedString {
        (try? AttributedString(markdown: markdownText)) ?? AttributedString()
    }
    var body: some View {
        VStack {
            HStack {
                Text("Markdown Editor")
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
            }
            GeometryReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        TextEditor(text: $markdownText)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(height: proxy.size.height / 2)
                            .bordered()
                        Divider()
                        Text(markdown)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }.padding()
    }
}

struct MarkdownEditorView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownEditorView()
    }
}
