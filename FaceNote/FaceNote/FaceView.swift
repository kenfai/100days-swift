//
//  FaceView.swift
//  FaceNote
//
//  Created by Ginger on 03/10/2020.
//

import SwiftUI

struct FaceView: View {
    var face: Face
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Text(self.face.name)
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
    }
}
/*
struct FaceView_Previews: PreviewProvider {
    static var previews: some View {
        FaceView()
    }
}
*/
