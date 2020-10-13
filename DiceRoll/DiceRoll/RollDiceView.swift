//
//  RollDiceView.swift
//  DiceRoll
//
//  Created by Ginger on 12/10/2020.
//

import SwiftUI
import CoreHaptics

struct RollDiceView: View {
    @EnvironmentObject var dice: Dice
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var result = 0
    @State private var engine: CHHapticEngine?
    @State private var counter = 0
    
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack {
                Text("\(self.result)")
                    .font(.largeTitle)
                    .frame(width: 100, height: 100)
                    .border(Color.black)
                    .onReceive(timer) { time in
                        if self.counter == 10 {
                            self.timer.upstream.connect().cancel()
                            
                            self.saveResult(result: self.result)
                        } else {
                            self.result = 0;
                            
                            for _ in 1...dice.quantity {
                                self.result += Int.random(in: 1...self.dice.sides)
                            }
                        }
                        
                        self.counter += 1
                    }
            }
                
            
            Button(action: {
                rollFeedback()
                
                self.counter = 0
                self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
            }) {
                Text("Roll Dice")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
            .frame(width: 200, height: 100)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.top, 100)
            .onAppear(perform: prepareHaptics)
        }
    }
    
    func saveResult(result: Int) {
        let roll = Roll(context: moc)
        roll.result = Int16(self.result)
        roll.created = Date()
        
        try? self.moc.save()
    }
    
    func rollVibrate() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func rollFeedback() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
