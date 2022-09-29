//
//  PTHScrollView.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/28/22.
//

import SwiftUI

/// Custom scroll view that supports dragging down to refresh functionality
struct PTHScrollView<Content: View>: View {
    let content: () -> Content
    
    @Environment(\.refresh) private var refresh
    @StateObject private var viewModel = PTHScrollViewModel()
    
    var body: some View {
        ScrollView {
            ZStack {
                content()
                
                GeometryReader { proxy in
                    Rectangle().fill(.clear)
                        .frame(width: 10, height: 10)
                        .preference(key: ScrollOffsetPreference.self, value: proxy.frame(in: .global).origin.y)
                }
            }
        }
        .onPreferenceChange(ScrollOffsetPreference.self) { value in
            viewModel.didUpdateOffset(value)
        }
        .onChange(of: viewModel.isRefreshing) { isRefreshing in
            guard isRefreshing else { return }
            
            Task {
                await refresh?()
            }
        }
    }
}

private struct ScrollOffsetPreference: PreferenceKey {
    static var defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct PTHScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PTHScrollView {
            Text("Custom Scroll View!")
        }
    }
}
