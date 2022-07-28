//
//  HomeViewModel.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/28.
//

import Foundation
import SwiftUI

enum TabType: Int, Identifiable, CaseIterable {
    var id: Int { return self.rawValue }
    
    case list = 0
    case newNote = 1
    case setting = 2
    
    
    var tabName: String {
        switch self {
        case .list:
            return "Notes"
        case .newNote:
            return "New"
        case .setting:
            return "Setting"
        }
    }
    
}
