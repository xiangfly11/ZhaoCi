//
//  SettingsView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/27.
//

import SwiftUI

struct SettingsView: View {
    let avatarSize: CGFloat = 120
    let userName: String
    
    init(userName: String) {
        self.userName = userName
    }
    
    var body: some View {
            VStack {
                ZStack {
                  VStack(spacing: 0) {
                    Rectangle()
                      .frame(height: 90)
                      .foregroundColor(
                        Color(red: 0.5, green: 0, blue: 0).opacity(0.2))
                    Rectangle()
                      .frame(height: 90)
                      .foregroundColor(
                        Color(red: 0.6, green: 0.1, blue: 0.1).opacity(0.4))
                  }
                    NavigationLink(destination: ProfileSettingView()) {
                        AvatarView( userName: "Jason", avatar: "person.fill")
                    }
                }
                .frame(height: 180)
                .navigationBarHidden(true)
                .navigationTitle("Setting")
              
                List {
                    
                    
                }
            }
    }
}

extension SettingsView {

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(userName: "Jason")
    }
}
