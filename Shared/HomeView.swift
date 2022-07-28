//
//  HomeView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/27.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = TabType.list.rawValue
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabType.allCases) { type in
                switch type {
                case .list:
                    NoteListView()
                        .tabItem {
                            TabItemView(tabName: type.tabName, tabIconName: "")
                                .tag(type.rawValue)
                        }
                case .newNote:
                    MarkdownEditorView()
                        .tabItem {
                            TabItemView(tabName: type.tabName, tabIconName: "")
                                .tag(type.rawValue)
                        }
                case .setting:
                    SettingsView(userName: "Jason")
                        .tabItem {
                            TabItemView(tabName: type.tabName, tabIconName: "")
                                .tag(type.rawValue)
                        }
                }
            }
        }
        .accentColor(.orange)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.portrait)
    }
}
