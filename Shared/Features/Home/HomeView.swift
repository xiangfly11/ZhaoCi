//
//  HomeView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/27.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = Tab.home
    @State private var plusDidClick = false
    
    init() {
       
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Group {
                    switch selectedTab {
                    case .home:
                        NoteListView()
                    case .setting:
                        SettingsView(userName: "Jason")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, 88.0)
                
                TabClipperShape(radius: 38.0)
                    .fill(Color("TabBarBackground"))
                    .frame(height: 88, alignment: .top)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                    .overlay(bottomBar)
                    .alert("点击了新增按钮", isPresented: $plusDidClick) {
                        Button("确定", role: .cancel) { }
                    }
            }
            .background(Color("Background"))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    var bottomBar: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(tabItems) { tabItem in
                Button(action: {
                    if tabItem.type == .TabType {
                        withAnimation(.easeInOut) {
                            selectedTab = tabItem.tab!
                        }
                    } else {
                    
                    }
                }) {
                    if tabItem.type == .TabType {
                        VStack(spacing: 0) {
                            Image(systemName: tabItem.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 44, height: 29)
                            Text(tabItem.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                    } else {
                        NavigationLink(destination: MarkdownEditorView()) {
                            Image(systemName: "plus")
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 56, height: 56)
                                .foregroundColor(Color.white)
                                .background(Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("FloatingButtonTopLeft"), Color("FloatingButtonBottomRight")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .shadow(color: Color.accentColor.opacity(0.3), radius: 10, x: 8, y: 16))
                                .offset(y: -35)
                        }
                    }
                }
                .foregroundColor(selectedTab == tabItem.tab ? .accentColor : .secondary)
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .frame(height: 88, alignment: .top)
        .padding(.horizontal, 8)
        .padding(.top, 14)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.portrait)
    }
}
