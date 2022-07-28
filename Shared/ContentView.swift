//
//  ContentView.swift
//  Shared
//
//  Created by Jiaxiang Li on 2022/7/22.
//

import SwiftUI

struct ContentView: View {
    @State var textField: String = ""

    var body: some View {
//        Text("Hello, world!")
//            .padding()
        HStack {
            TextField.init("hello", text: $textField)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
