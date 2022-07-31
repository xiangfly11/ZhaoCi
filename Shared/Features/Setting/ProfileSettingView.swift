//
//  ProfileSettingView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/27.
//

import SwiftUI

struct ProfileSettingView: View {
    @State var test: String = ""
    init() {
        
    }
    var body: some View {
        VStack {
          TextEditor(text: $test)
        }
        .background(.red)
    }
}

struct ProfileSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingView()
    }
}
