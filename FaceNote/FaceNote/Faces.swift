//
//  Faces.swift
//  FaceNote
//
//  Created by Ginger on 03/10/2020.
//

import Foundation

class Faces: ObservableObject {
    @Published var items = [Face]()
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func addFace(face: Face) {
        self.items.append(face)
        
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedFaces")
            let data = try JSONEncoder().encode(self.items)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
}
