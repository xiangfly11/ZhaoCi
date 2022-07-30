//
//  iOSPreview.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/28.
//

import SwiftUI
import WebKit

struct iOSPreview: UIViewRepresentable {
    var html: String
    
    init(html: String) {
        self.html = html
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.backgroundColor = UIColor.yuDuBai
        webview.isOpaque = false
        webview.scrollView.backgroundColor = .clear
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let viewportStr = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>img{max-width:100%}</style></header>"
        uiView.loadHTMLString(viewportStr.appending(html), baseURL: nil)
    }
}
