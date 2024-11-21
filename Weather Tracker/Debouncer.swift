//
//  Debouncer.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import Foundation

class Debouncer {
    private var workItem: DispatchWorkItem?
    private let delay: TimeInterval
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    func call(action: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        if let workItem = workItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
        }
    }
}
