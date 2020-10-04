//
//  FaceView.swift
//  FaceNote
//
//  Created by Ginger on 03/10/2020.
//

import SwiftUI
import MapKit

struct FaceView: View {
    var face: Face
    @State private var image: Image?
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var locations = [MKPointAnnotation]()
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Text(self.face.name)
            
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, annotations: self.locations)
        }
        .onAppear(perform: loadImage)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func loadImage()
    {
        let path = getDocumentsDirectory().appendingPathComponent(self.face.photo)
        
        do {
            let result = try Data(contentsOf: path)
            
            guard let uiImage = UIImage(data: result) else { return }
            
            self.image = Image(uiImage: uiImage)
        } catch {
            print("Cannot load image")
        }
        
        self.centerCoordinate = CLLocationCoordinate2D(latitude: (self.face.latitude ?? 0.0), longitude: (self.face.longitude ?? 0.0))
        
        let newLocation = MKPointAnnotation()
        newLocation.coordinate = CLLocationCoordinate2D(latitude: (self.face.latitude ?? 0.0), longitude: (self.face.longitude ?? 0.0))
        self.locations.append(newLocation)
        self.selectedPlace = newLocation
        
    }
}
/*
struct FaceView_Previews: PreviewProvider {
    static var previews: some View {
        FaceView()
    }
}
*/
