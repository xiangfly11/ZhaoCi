//
//  HomeView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/27.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = TabType.list.rawValue
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.bengRouBai
    }
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedTab) {
                ForEach(TabType.allCases) { type in
                    switch type {
                    case .list:
                        NoteListView()
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .tabItem {
                                TabItemView(tabName: type.tabName, tabIconName: "")
                                    .tag(type.rawValue)
                            }
                    case .newNote:
                        MarkdownEditorView()
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .tabItem {
                                TabItemView(tabName: type.tabName, tabIconName: "")
                                    .tag(type.rawValue)
                            }
                    case .setting:
                        SettingsView(userName: "Jason")
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .tabItem {
                                TabItemView(tabName: type.tabName, tabIconName: "")
                                    .tag(type.rawValue)
                            }
                    }
                }
            }
            .accentColor(Color(UIColor.chenXiHong))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.portrait)
    }
}
