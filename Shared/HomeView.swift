//
//  HomeView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/27.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NoteListView()
                .tabItem {
                    TabItemView(tabName: "Notes", tabIconName: "")
                        .tag(1)
                }
            SettingsView(userName: "Jasn")
                .tabItem {
                    TabItemView(tabName: "Settings", tabIconName: "")
                }
        }
        .accentColor(.orange)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
