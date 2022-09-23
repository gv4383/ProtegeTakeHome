//
//  PTHLoadingView.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/22/22.
//

import SwiftUI

struct PTHLoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PTHLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        PTHLoadingView()
    }
}
