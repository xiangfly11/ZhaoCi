//
//  NoteListViewModel.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/28.
//

import SwiftUI

enum ListType: Int16, Identifiable, CaseIterable {
    var id: Int16 { self.rawValue }
    
    case all = 3
    case notes = 0
    case drafts = 1
    case trash = 2
    

    var listTypeName: String {
        switch self {
        case .notes:
            return "笔记"
        case .drafts:
            return "草稿"
        case .trash:
            return "垃圾箱"
        case .all:
            return "所有"
        }
    }
    
    static func listName(index: Int) -> String {
        return ListType.allCases.first(where: { $0.rawValue == index })?.listTypeName ?? ""
    }
}
