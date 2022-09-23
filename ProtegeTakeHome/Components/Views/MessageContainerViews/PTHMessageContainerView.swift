//
//  PTHMessageContainerView.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/23/22.
//

import SwiftUI

struct PTHMessageContainerView: View {
    let messageText: String
    let isPrimaryMessenger: Bool
    
    var foregroundColor: Color {
        isPrimaryMessenger ? .white : .primary
    }
    
    var backgroundColor: Color {
        isPrimaryMessenger ? .blue : .gray.opacity(0.3)
    }
    
    var body: some View {
        Text(messageText)
            .foregroundColor(foregroundColor)
            .padding()
            .background(backgroundColor)
            .cornerRadius(16)
    }
}

struct PTHMessageContainerView_Previews: PreviewProvider {
    static var previews: some View {
        PTHMessageContainerView(messageText: "Wut up!! Gonna be in town late", isPrimaryMessenger: false)
    }
}
