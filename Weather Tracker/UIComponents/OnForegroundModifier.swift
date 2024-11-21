//
//  OnForegroundModifier.swift
//  Weather Tracker
//
//  Created by Anthony Harvey on 11/20/24.
//

import SwiftUI

struct OnForegroundModifier: ViewModifier {
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                action()
            }
    }
}

extension View {
    func onForeground(_ perform: @escaping () -> Void) -> some View {
        self.modifier(OnForegroundModifier(action: perform))
    }
}
