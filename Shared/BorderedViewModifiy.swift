//
//  BorderedViewModifiy.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/7/27.
//

import SwiftUI

struct BorderedViewModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
          .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(lineWidth: 2)
              .foregroundColor(.blue)
          )
          .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
      .background(Color.white)
      
  }
}

extension View {
  func bordered() -> some View {
    ModifiedContent(content: self, modifier: BorderedViewModifier())
  }
}
