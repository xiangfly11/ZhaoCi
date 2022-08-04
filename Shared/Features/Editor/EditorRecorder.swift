//
//  EditorRecorder.swift
//  ZhaoCi (iOS)
//
//  Created by Jiaxiang Li on 2022/8/4.
//

import Foundation
import SwiftUI

struct recordItem {
    var text: String?
}


public class EditorRecord {
    
    @Published public var backwardAvailable: Bool = false
    @Published public var forwardAvailable: Bool = false

    
    enum RecordOperationType {
        case push
        case pop
        case none
    }
    
    public enum TrackOperationType {
        case forward
        case backward
    }
    
    
    /// 默认使用单例
    public static var shared: EditorRecord = .init()
    
    private var recordIemList: [recordItem] = []
    
    private var currentStep: Int = -1 {
        didSet {
            _forwardAvailable =  Published.init(initialValue: currentStep > -1)
            _backwardAvailable = Published.init(initialValue: currentStep < recordIemList.count - 1)
        }
    }
    
    private let defaultSteps: Int = 5
    
    private var currentOperation: RecordOperationType = .none
    
//    public init(backward: Binding<Bool>, forward: Binding<Bool>) {
//        _forwardAvailable = forward
//        _backwardAvailable = backward
//    }
    
//    public convenience init(backwardAvailable: Binding<Bool>? = nil, forwardAvailable: Binding<Bool>? = nil) {
//        self.init()
////        self.forwardAvailable = forwardAvailable
////        self.backwardAvailable = backwardAvailable
//    }
    
    //MARK: Public Methods
    public func pushContent(text: String) {
        let item = recordItem.init(text: text)
        if currentOperation == .pop, currentStep >= 0, currentStep < recordIemList.count {
            recordIemList.removeSubrange((currentStep + 1..<recordIemList.count))
        }
        
        currentStep = recordIemList.count
        recordIemList.append(item)
        currentOperation = .push
        
        if currentStep >= defaultSteps {
            let redoundent = currentStep - defaultSteps
            recordIemList.removeSubrange((0...redoundent))
            currentStep = recordIemList.count - 1
        }
        
        print("**************** \(text) step:\(currentStep)")
    }
    
    
    func popContent(trackType: TrackOperationType) -> String {
        var tempStep = currentStep
        switch trackType {
        case .forward:
            tempStep += 1
        case .backward:
            tempStep -= 1
        }
        
        guard tempStep >= 0  else {
            currentStep = -1
            return ""
        }
        
        guard tempStep < recordIemList.count else {
            return recordIemList.last?.text ?? ""
        }
        
        currentStep = tempStep
        let lastItem = recordIemList[currentStep]
        currentOperation = .pop
        print("&&&&&&&&&&&&& \(lastItem.text) step: \(currentStep)")
        return lastItem.text ?? ""
    }
    
    
    public func forward() -> String {
        return popContent(trackType: .forward)
    }
    
    public func backward() -> String {
        return popContent(trackType: .backward)
    }
    
    
    public func cleanCache() {
        recordIemList.removeAll()
        currentStep = 0
        currentOperation = .none
    }
}
