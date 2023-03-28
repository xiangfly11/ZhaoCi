//
//  iOSPreview.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/28.
//

import SwiftUI
import MarkdownUI

struct iOSPreview: View {
    var title: String
    var content: String
    var body: some View {
       ContentPreviewView(content: {
           Markdown {
             Heading(.level2) {
               title
             }
             content
           }
       })
    }
}

struct iOSPreview_Previews: PreviewProvider {
    static var previews: some View {
        iOSPreview(title: "Hello", content: "## hello ##")
    }
}
