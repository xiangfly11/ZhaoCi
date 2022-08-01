//
//  FontExt.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/8/1.
//

import Foundation
import SwiftUI

extension Font {
    
    public static func WenKaiMonoRegular(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return custom("LXGWWenKaiMono-Bold", size: size).weight(weight)
    }
    
    public static func WenKaiMonoBold(size: CGFloat, weight: Font.Weight = .bold) -> Font {
        return custom("LXGWWenKaiMono-Bold", size: size).weight(weight)
    }
}
