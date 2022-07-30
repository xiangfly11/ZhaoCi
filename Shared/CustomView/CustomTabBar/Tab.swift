//
//  SettingsView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/31.
//

import SwiftUI


enum TabItemType {
    case TabType
    case ButtonType
}

struct TabItem: Identifiable {
    
    var id = UUID()
    
    var type: TabItemType
    var icon: String
    var text: String
    var tab: Tab?
    
}

enum Tab: String {
    case home
    case setting
}

var tabItems = [
    TabItem(type: .TabType, icon: "house", text: "首页", tab: .home),
    TabItem(type: .ButtonType, icon: "plus", text: "新增", tab: nil),
    TabItem(type: .TabType, icon: "person", text: "设置", tab: .setting),
]
