


import SwiftUI
import CoreHaptics

struct WeightSelectionTemplate: View {
    @State private var targetWeight: Double = 167
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                VStack {
                    Text("what is your goal weight?")
                        .localizedFont(size: 28, weight: .bold)
                      //  .multilineTextAlignment(.trailing)
                    
                    Text("we use these info to help you")
                        .localizedFont(size: 16, weight: .regular)
                        .foregroundColor(.black)
                   //     .multilineTextAlignment(.trailing)
                }
             //   .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 24)
                .padding(.top, 24)
                
                Spacer()
                
                Text("gain weight?")
                    .localizedFont(size: 20, weight: .regular)
                    .padding(.bottom, 16)
                
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("KG")
                        .localizedFont(size: 24, weight: .regular)
                        .foregroundColor(.black)

                    Text("\(Int(targetWeight))")
                        .localizedFont(size: 48, weight: .bold)
                        .foregroundColor(.black)
                }
                .padding(.bottom, 40)
                
                WeightSlider(value: $targetWeight, range: 40...250, onSlide: triggerHapticFeedback)
                    .frame(height: 80.0)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                Button(action: {
                    // Action for next button
                }) {
                    Text("Next")
                        .localizedFont(size: 18, weight: .semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(30)
                        .padding(.horizontal, 24)
                }
                
            }
        }
        .onAppear {
            prepareHaptics()
        }
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the haptic engine: \(error.localizedDescription)")
        }
    }
    
    private func triggerHapticFeedback() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine = engine else { return }
        
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play haptic pattern: \(error.localizedDescription)")
        }
    }
}

// No font changes needed inside the slider
struct WeightSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let onSlide: () -> Void
    
    @State private var isEditing = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                HStack(spacing: geometry.size.width / 12) {
                    ForEach(0..<12, id: \.self) { _ in
                        Rectangle()
                            .fill(Color(white: 0.9))
                            .frame(width: 1, height: 24)
                    }
                }
                .frame(width: geometry.size.width, alignment: .center)
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(white: 0.7))
                    .frame(width: 24, height: 80)
                    .position(x: self.positionForValue(geometry: geometry), y: geometry.size.height / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.isEditing = true
                                let newValue = self.valueForPosition(geometry: geometry, position: gesture.location.x)
                                if abs(newValue - self.value) >= 0.5 {
                                    self.value = newValue
                                    self.onSlide()
                                }
                            }
                            .onEnded { _ in
                                self.isEditing = false
                            }
                    )
            }
        }
    }
    
    private func positionForValue(geometry: GeometryProxy) -> CGFloat {
        let percentage = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return max(0, min(geometry.size.width, CGFloat(percentage) * geometry.size.width))
    }
    
    private func valueForPosition(geometry: GeometryProxy, position: CGFloat) -> Double {
        let clampedPosition = max(0, min(geometry.size.width, position))
        let percentage = Double(clampedPosition / geometry.size.width)
        return range.lowerBound + percentage * (range.upperBound - range.lowerBound)
    }
}

struct WeightSelectionTemplate_Previews: PreviewProvider {
    static var previews: some View {
        WeightSelectionTemplate()
    }
}
