//
//  PTHPrimaryMessageContainerView.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/23/22.
//

import SwiftUI

struct PTHPrimaryMessageContainerView: View {
    let messageText: String
    
    var body: some View {
        HStack {
            PTHMessageContainerView(messageText: messageText, isPrimaryMessenger: true)
                .frame(maxWidth: 256, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct PTHPrimaryMessageContainerView_Previews: PreviewProvider {
    static var previews: some View {
        PTHPrimaryMessageContainerView(messageText: "Wut up!! Gonna be in town late")
    }
}
