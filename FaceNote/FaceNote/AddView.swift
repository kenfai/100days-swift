//
//  AddView.swift
//  FaceNote
//
//  Created by Ginger on 03/10/2020.
//

import SwiftUI
import MapKit

struct AddView: View {
    @ObservedObject var faces: Faces
    @Environment(\.presentationMode) var presentationMode
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false;
    @State private var name = ""
    @State private var image: Image?
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    
                    if image == nil {
                        Text("Tap to select photo")
                            .onTapGesture {
                                self.showingImagePicker = true;
                            }
                    } else {
                        image?
                        .resizable()
                        .scaledToFit()
                    }
                }
                
                Form {
                    TextField("Who is this person?", text: $name)
                }
            }
            .navigationBarTitle(Text("Add Face"))
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button(action: saveData) {
                Text("Save")
            })
            .sheet(isPresented: $showingImagePicker, onDismiss: {
                guard let uiImage = self.inputImage else { return }
                
                self.image = Image(uiImage: uiImage)
            }) {
                ImagePicker(image: self.$inputImage)
            }
            .onAppear(perform: self.locationFetcher.start)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func saveData()
    {
        guard let uiImage = self.inputImage else { return }
        
        let url = getDocumentsDirectory().appendingPathComponent(self.name)

        if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
        }
        
        let location = self.locationFetcher.lastKnownLocation
        
        let face = Face(photo: self.name, name: self.name, latitude: location?.latitude, longitude: location?.longitude)
        self.faces.addFace(face: face)
        
        presentationMode.wrappedValue.dismiss()
    }
}
/*
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
*/
