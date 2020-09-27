//
//  ContentView.swift
//  Instafilter
//
//  Created by Ginger on 24/09/2020.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 10.0
    @State private var filterScale = 1.0
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var selectedFilter = "Change Filter"
    
    @State private var processedImage: UIImage?
    
    // Alert
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        let scale = Binding<Double>(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    // display the image
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)
                
                HStack {
                    Text("Radius")
                    Slider(value: radius, in: 0...100, step: 1)
                }.padding(.vertical)
                
                HStack {
                    Text("Scale")
                    Slider(value: scale, in: 0...100, step: 1)
                }.padding(.vertical)
                
                HStack {
                    Button(self.selectedFilter) {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        // save the picture
                        guard let processedImage = self.processedImage else {
                            self.alertTitle = "Image is Empty!"
                            self.alertMessage = "Please select an image to save"
                            self.showingAlert = true
                            return
                        }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter") // iOS 13
            //.navigationTitle("Instafilter") // iOS 14
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a Filter"), buttons: [
                    .default(Text("Crystallize")) {
                        self.selectedFilter = "Crystallize"
                        self.setFilter(CIFilter.crystallize())
                    },
                    .default(Text("Edges")) {
                        self.selectedFilter = "Edges"
                        self.setFilter(CIFilter.edges())
                    },
                    .default(Text("Gaussian Blur")) {
                        self.setFilter(CIFilter.gaussianBlur())
                        self.selectedFilter = "Gaussian Blur"
                    },
                    .default(Text("Bokeh Blur")) {
                        self.setFilter(CIFilter.bokehBlur())
                        self.selectedFilter = "Bokeh Blur"
                    },
                    .default(Text("Pixellate")) {
                        self.setFilter(CIFilter.pixellate())
                        self.selectedFilter = "Pixellate"
                    },
                    .default(Text("Sepia Tone")) {
                        self.setFilter(CIFilter.sepiaTone())
                        self.selectedFilter = "Sepia Tone"
                    },
                    .default(Text("Unsharp Mask")) {
                        self.setFilter(CIFilter.unsharpMask())
                        self.selectedFilter = "Unsharp Mask"
                    },
                    .default(Text("Vignette")) {
                        self.setFilter(CIFilter.vignette())
                        self.selectedFilter = "Vignette"
                    },
                    .default(Text("False Color")) {
                        self.setFilter(CIFilter.falseColor())
                        self.selectedFilter = "False Color"
                    },
                    .default(Text("Bloom")) {
                        self.setFilter(CIFilter.bloom())
                        self.selectedFilter = "Bloom"
                    },
                    .default(Text("Gloom")) {
                        self.setFilter(CIFilter.gloom())
                        self.selectedFilter = "Gloom"
                    },
                    .default(Text("Comic Effect")) {
                        self.setFilter(CIFilter.comicEffect())
                        self.selectedFilter = "Comic Effect"
                    },
                    .default(Text("Fade")) {
                        self.setFilter(CIFilter.photoEffectFade())
                        self.selectedFilter = "Fade"
                    },
                    .default(Text("Thermal")) {
                        self.setFilter(CIFilter.thermal())
                        self.selectedFilter = "Thermal"
                    },
                    .default(Text("Vibrance")) {
                        self.setFilter(CIFilter.vibrance())
                        self.selectedFilter = "Vibrance"
                    },
                    .default(Text("X-Ray")) {
                        self.setFilter(CIFilter.xRay())
                        self.selectedFilter = "X-Ray"
                    },
                    .cancel()
                ])
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        //image = Image(uiImage: inputImage)
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        //currentFilter.intensity = Float(filterIntensity)
        //currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
        
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
