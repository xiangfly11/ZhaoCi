//
//  MarkdownEditorViewModel.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/28.
//

import SwiftUI

enum MarkdownEditorType: Int, Identifiable, CaseIterable {
    var id: Int { self.rawValue }
    
    case editor = 0
    case preview = 1
    
    var markdownEditorTypeName: String {
        switch self {
        case .editor:
            return "Editor"
        case .preview:
            return "Preview"
        }
    }
}
