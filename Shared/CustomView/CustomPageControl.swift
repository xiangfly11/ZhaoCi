//
//  CustomPageControl.swift
//  ZhaoCi (iOS)
//
//  Created by Jiaxiang Li on 2022/8/9.
//

import SwiftUI

struct CustomPageControl: View {
    
    @Binding var selectedPage: Int
    var titleItems: [TitleItem] = [TitleItem(titleStr: "编辑"), TitleItem(titleStr: "预览")]
    
    var body: some View {
        ZStack(alignment: .leading, content: {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                let titleWidth = width / CGFloat(titleItems.count) - 5
                let indicatorOffsetX = CGFloat(selectedPage) * (titleWidth - 5)
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1.5)
                
                HStack(alignment: .center, spacing: 0, content: {
                    ForEach(titleItems) { item in
                        Button {
                            let index = titleItems.firstIndex(where: { $0.titleStr == item.titleStr })
                            selectedPage = index ?? 0
                        } label: {
                            Text(item.titleStr)
                                .frame(width: titleWidth, height: height, alignment: .center)
                        }
                        
                    }
                })
                .font(Font.WenKaiMonoBold(size: 16))
                .foregroundColor(Color(UIColor.chenXiHong))
                
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.2))
                
                CustomCurrentIndicator()
                    .frame(width: titleWidth)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .offset(x: indicatorOffsetX)
            }
        })
    }
}

struct CustomCurrentIndicator: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.green.opacity(0.4))
    }
}

struct TitleItem: Identifiable {
    
    var id = UUID()
    
    var titleStr: String

}


struct CustomPageControl_Previews: PreviewProvider {
    @State static var selectedPage: Int = 0
    static var previews: some View {
        CustomPageControl(selectedPage: $selectedPage).frame(width: 150, height: 44)
    }
}
