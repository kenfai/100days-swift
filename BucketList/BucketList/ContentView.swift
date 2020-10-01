//
//  ContentView.swift
//  BucketList
//
//  Created by Ginger on 27/09/2020.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false

    @State private var isUnlocked = false
    
    @State private var activeAlertType: AlertType = .placeDetails
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    enum AlertType {
        case placeDetails
        case error
    }

    var body: some View {
        ZStack {
            if isUnlocked {
                FullMapView(centerCoordinate: $centerCoordinate,
                            locations: $locations,
                            selectedPlace: $selectedPlace,
                            showingPlaceDetails: $showingPlaceDetails,
                            showingEditScreen: $showingEditScreen)
                    .onAppear(perform: loadData)
            } else {
                // button here
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color(.white))
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            switch activeAlertType {
            case .placeDetails:
                return Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                    // edit this place
                    self.showingEditScreen = true
                })
            case .error:
                return Alert(title: Text(alertTitle), message: Text(alertMessage))
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
    }

    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                        self.activeAlertType = .error
                        self.alertTitle = "Authentication Error"
                        self.alertMessage = authenticationError?.localizedDescription ?? "Unknown Error"
                        self.showingPlaceDetails = true
                    }
                }
            }
        } else {
            self.activeAlertType = .error
            self.alertTitle = "Authentication Error"
            self.alertMessage = "Your devices does not support Face ID or Touch ID."
            self.showingPlaceDetails = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
