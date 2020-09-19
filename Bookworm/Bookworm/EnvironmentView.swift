//
//  EnvironmentView.swift
//  Bookworm
//
//  Created by Ginger on 19/09/2020.
//

import SwiftUI

struct EnvironmentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active Size Class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active Size Class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}

struct EnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentView()
    }
}
