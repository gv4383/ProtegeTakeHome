//
//  PTHDateLabelView.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/23/22.
//

import SwiftUI

struct PTHDateLabelView: View {
    let date: Date
    
    var body: some View {
        Text(DateFormatHelper.formatDate(date))
            .opacity(0.5)
    }
}

struct PTHDateLabelView_Previews: PreviewProvider {
    static var previews: some View {
        PTHDateLabelView(date: Date())
    }
}
