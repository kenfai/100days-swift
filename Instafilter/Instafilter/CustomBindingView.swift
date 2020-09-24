//
//  CustomBindingView.swift
//  Instafilter
//
//  Created by Ginger on 24/09/2020.
//

import SwiftUI

struct CustomBindingView: View {
    @State private var blurAmount: CGFloat = 0
    
    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
        
        return VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: blur, in: 0...20)
        }
    }
}

struct CustomBindingView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBindingView()
    }
}
