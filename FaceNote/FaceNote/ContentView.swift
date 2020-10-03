//
//  ContentView.swift
//  FaceNote
//
//  Created by Ginger on 03/10/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var faces: Faces = Faces()
    @State private var showingAddView = false;
    
    var body: some View {
        NavigationView {
            List(faces.items.sorted(), id:\.self.id) { face in
                NavigationLink(destination: FaceView(face: face)) {
                    Text(face.name)
                }
            }
            .navigationBarTitle(Text("FaceNote"))
            .navigationBarItems(trailing: Image(systemName: "plus")
                                    .onTapGesture {
                                        self.showingAddView = true;
                                    })
            .sheet(isPresented: $showingAddView) {
                AddView(faces: faces)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func loadData()
    {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedFaces")
        
        do {
            let data = try Data(contentsOf: filename)
            let facesData = try JSONDecoder().decode([Face].self, from: data)
            
            for face in facesData {
                self.faces.addFace(face: face)
            }
        } catch {
            print("Unable to load data")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
