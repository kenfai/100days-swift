//
//  TechnicView.swift
//  Flashzilla
//
//  Created by Ginger on 09/10/2020.
//

import SwiftUI
import CoreHaptics

struct TechnicView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var  differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @State private var scale: CGFloat = 1
    
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1
    
    @State private var currentRotateAmount: Angle = .degrees(0)
    @State private var finalRotateAmount: Angle = .degrees(0)
    
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    
    // whether it is currently being dragged or not
    @State private var isDragging = false
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in self.offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }
        
        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragging = true
                }
            }
        
        
        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)
        
        return VStack {
            
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                
                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? Color.black : Color.green)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            
            Text("Home Returned")
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    print("Moving to the background!")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("Moving back to the foreground!")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                    print("User took a screenshot!")
                }
            
            Text("Counting down..")
                .onReceive(timer) { time in
                    if self.counter == 5 {
                        self.timer.upstream.connect().cancel()
                    } else {
                        print("The time is now \(time)")
                    }
                    
                    self.counter += 1
                }
            
            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("VStack tapped")
            }
            
            Text("motion sickness")
                .scaleEffect(scale)
                .onTapGesture {
                    withOptionalAnimation {
                        self.scale *= 1.5
                    }
                    /*if self.reduceMotion {
                        self.scale *= 1.5
                    } else {
                        withAnimation {
                            self.scale *= 1.5
                        }
                    }*/
                }
            
            Text("Blur text")
                .padding()
                .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
                .foregroundColor(Color.white)
                .clipShape(Capsule())
            
            VStack {
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 100, height: 100)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("Circle tapped!")
                    }
                
                ZStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 300, height: 300)
                        .onTapGesture {
                            print("Rectangle tapped!")
                        }
                    
                    Circle()
                        .fill(Color.green)
                        .frame(width: 300, height: 300)
                        .onTapGesture {
                            print("Circle tapped!")
                        }
                        .allowsHitTesting(false)
                }
                
                Text("Begin Complex Haptics")
                    .onAppear(perform: prepareHaptics)
                    .onTapGesture(perform: complexSuccess)
                
                Text("Shake if off")
                    .onTapGesture(perform: simpleSuccess)
                
                // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
                Circle()
                    .fill(Color.red)
                    .frame(width: 60, height: 60)
                    .scaleEffect(isDragging ? 1.5 : 1)
                    .offset(offset)
                    .gesture(combined)
            }
            
            VStack {
                Text("Tap me all")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )
            
            VStack {
                Text("Double Hello")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .highPriorityGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )
            VStack {
                Text("Hello, world!")
                    .onTapGesture(count: 2) {
                        print("Double Tap!")
                    }
                
                Text("Rotate me")
                    .rotationEffect(currentRotateAmount + finalRotateAmount)
                    .gesture(
                        RotationGesture()
                            .onChanged { angle in
                                self.currentRotateAmount = angle
                            }
                            .onEnded { angle in
                                self.finalRotateAmount += self.currentRotateAmount
                                self.currentRotateAmount = .degrees(0)
                            }
                    )
                
                Text("Pinch Me!")
                    .scaleEffect(finalAmount + currentAmount)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { amount in
                                self.currentAmount = amount - 1
                            }
                            .onEnded { amount in
                                self.finalAmount += self.currentAmount
                                self.currentAmount = 0
                            }
                    )
                
                Text("Hey There!")
                    .onLongPressGesture(minimumDuration: 2, pressing: { inProgress in
                        print("In progress \(inProgress)")
                    }) {
                        print("Long press")
                    }
            }
        }
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        print("shake!")
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
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        // create one intense, sharp tap
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
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

struct TechnicView_Previews: PreviewProvider {
    static var previews: some View {
        TechnicView()
    }
}
