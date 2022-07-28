//
//  NoteListViewModel.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/28.
//

import SwiftUI

enum ListType: Int, Identifiable, CaseIterable {
    var id: Int { self.rawValue }
    
    case notes = 0
    case drafts = 1
    case trash = 2

    var listTypeName: String {
        switch self {
        case .notes:
            return "Notes"
        case .drafts:
            return "Drafts"
        case .trash:
            return "Trash"
        }
    }
    
    static func listName(index: Int) -> String {
        return ListType.allCases.first(where: { $0.rawValue == index })?.listTypeName ?? ""
    }
}
