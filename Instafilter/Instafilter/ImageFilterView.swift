//
//  ImageFilterView.swift
//  Instafilter
//
//  Created by Ginger on 25/09/2020.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ImageFilterView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }.onAppear(perform: loadImage)
    }
    
    func loadImage() {
        //image = Image("Example")
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
        // Apply sepia tone
        /*let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1*/
        
        // Apply pixellate effect
        /*let currentFilter = CIFilter.pixellate()
        currentFilter.inputImage = beginImage
        currentFilter.scale = 100*/
        
        // Apply crystalize effect
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage
        currentFilter.radius = 200
        
        // Apply Twirl Distortion
        /*let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage
        currentFilter.radius = 2000
        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)*/
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            
            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}

struct ImageFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFilterView()
    }
}
