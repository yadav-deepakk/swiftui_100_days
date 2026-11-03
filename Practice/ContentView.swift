//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import CoreHaptics
import SwiftUI

struct ContentView : View {
    @State private var count = 0
    @State private var hapticEngine: CHHapticEngine?
    
    var body: some View {
        Button("Tap me", action: complexSuccess)
            .onAppear(perform: prepareHapics)
    }
    
    func prepareHapics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics == true else {
            print("haptics are not supported by the hardware")
            return
        }
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("unable to start haptic engine")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics == true else { return }
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
        let event = CHHapticEvent( eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            
        } catch {
            print ("error in playing pattern \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
