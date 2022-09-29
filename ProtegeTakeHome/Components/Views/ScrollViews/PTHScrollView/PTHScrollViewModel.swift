//
//  PTHScrollViewModel.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/28/22.
//

import SwiftUI

extension PTHScrollView {
    final class PTHScrollViewModel: ObservableObject {
        @Published var isRefreshing = false
        
        private var offset: CGFloat?
        private var initialOffset: CGFloat = 0.0
        private let distanceToTriggerRefresh: CGFloat = 20
        
        func didUpdateOffset(_ value: CGFloat) {
            if let _ = offset {
                // Ongoing scroll
                
                self.offset = value
                let difference = value - initialOffset
                
                if difference > distanceToTriggerRefresh, !isRefreshing {
                    isRefreshing = true
                } else if difference < 0 {
                    isRefreshing = false
                }
            } else {
                // Starting to scroll
                
                self.offset = value
                self.initialOffset = value
            }
        }
    }
}
