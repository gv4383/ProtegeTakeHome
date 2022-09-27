//
//  PTHSecondaryMessageContainerView.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/23/22.
//

import SwiftUI

struct PTHSecondaryMessageContainerView: View {
    let messageText: String
    
    var body: some View {
        HStack {
            PTHMessageContainerView(messageText: messageText, isPrimaryMessenger: false)
                .frame(maxWidth: 256, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct PTHSecondaryMessageContainerView_Previews: PreviewProvider {
    static var previews: some View {
        PTHSecondaryMessageContainerView(messageText: "Wut up!! Gonna be in town late")
    }
}
