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
            }
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
                                .font(.WenKaiMonoBold(size: 12))
                                .lineLimit(1)
                        }
                        .offset(y: 20)
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
                                .offset(y: -10)
                        }
                    }
                }
                .foregroundColor(selectedTab == tabItem.tab ? .accentColor : .secondary)
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .frame(height: 130, alignment: .top)
        .padding(.horizontal, 8)
        .padding(.top, 14)
//        .background(Color.red)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.portrait)
    }
}
