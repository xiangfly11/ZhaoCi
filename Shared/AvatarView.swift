//
//  AvatarBtn.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/27.
//

import SwiftUI

struct AvatarView: View {
    let avatarSize: CGFloat = 120
    let userName: String
    let avatar: String
    
    init(userName: String, avatar: String) {
        self.userName = userName
        self.avatar = avatar
    }
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .padding()
                .frame(width: avatarSize, height: avatarSize)
                .background(Color.white.opacity(0.5))
                .cornerRadius(avatarSize / 2, antialiased: true)
                .shadow(radius: 4)
            Text(userName)
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .shadow(radius: 7)
        }
        
        
    }
}

struct AvatarBtn_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(userName: "Jason", avatar: "person.fill")
    }
}
