//
//  TabItemView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/27.
//

import SwiftUI

struct TabItemView: View {
    var tabName = ""
    var tabIconName = ""
    var body: some View {
        VStack {
            Image(systemName: tabIconName)
            Text(tabName)
        }
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(tabName: "Hello", tabIconName: "")
    }
}
