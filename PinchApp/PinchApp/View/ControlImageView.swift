//
//  ControlImageView.swift
//  PinchApp
//
//  Created by Rushikesh Suradkar on 29/03/24.
//

import SwiftUI

struct ControlImageView: View {
    var icon : String
    var body: some View {
            Image(systemName: icon)
                .font(.system(size: 30))
    }
}

#Preview {
    ControlImageView(icon: "minus.magnifyingglass")
}
