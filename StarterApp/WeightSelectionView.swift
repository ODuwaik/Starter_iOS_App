import SwiftUI
import CoreHaptics

struct WeightSelectionView: View {
    @State private var targetWeight: Double = 167
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        VStack {
            Spacer()
            
            // Header text in Arabic (right-to-left)
            Text("وش الوزن اللي تبي توصل له؟")
                .font(.custom("BalooBhaijaan2-Regular", size: 28))
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            
            // Subheader text
            Text("نستخدم هذي المعلومات لتخصيص خطتك الشخصية")
                .font(.custom("BalooBhaijaan2-Regular", size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .padding(.top, 4)
            
            Spacer()
            
            // Weight goal text
            Text("تبي تزيد وزنك")
                .font(.custom("BalooBhaijaan2-Regular", size: 20))
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            
            // Weight value display
            HStack {
                Text("كجم")
                    .font(.custom("BalooBhaijaan2-Regular", size: 24))
                
                Text("\(Int(targetWeight))")
                    .font(.custom("BalooBhaijaan2-Bold", size: 48))
            }
            .padding(.bottom, 24)
            
            // Custom slider
            SliderView(value: $targetWeight, range: 40...250, onSlide: triggerHapticFeedback)
                .frame(height: 40)
                .padding(.horizontal)
            
            Spacer()
            
            // Next button
            Button(action: {
                // Action for next button
            }) {
                Text("التالي")
                    .font(.custom("BalooBhaijaan2-SemiBold", size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(30)
                    .padding(.horizontal)
            }
            .padding(.bottom, 40)
            
            // Bottom indicator
            Rectangle()
                .frame(width: 120, height: 4)
                .cornerRadius(2)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
        }
        .environment(\.layoutDirection, .rightToLeft) // For Arabic layout
        .onAppear {
            prepareHaptics()
        }
    }
    
    // Prepare haptic engine
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the haptic engine: \(error.localizedDescription)")
        }
    }
    
    // Trigger haptic feedback
    private func triggerHapticFeedback() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine = engine else { return }
        
        // Create a haptic pattern
        var events = [CHHapticEvent]()
        
        // Create an intensity parameter
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        
        // Create an event
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        // Convert events into a pattern and play it
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play haptic pattern: \(error.localizedDescription)")
        }
    }
}

// Custom slider view
struct SliderView: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let onSlide: () -> Void
    
    @State private var isEditing = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background track
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.2))
                    .frame(width: geometry.size.width, height: 8)
                    .cornerRadius(4)
                
                // Filled track
                Rectangle()
                    .foregroundColor(Color.gray)
                    .frame(width: self.widthForValue(geometry: geometry), height: 8)
                    .cornerRadius(4)
                
                // Thumb
                Circle()
                    .foregroundColor(Color.gray)
                    .frame(width: 40, height: 40)
                    .position(x: self.positionForValue(geometry: geometry), y: geometry.size.height / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.isEditing = true
                                let newValue = self.valueForPosition(geometry: geometry, position: gesture.location.x)
                                if newValue != self.value {
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
        return max(20, min(geometry.size.width - 20, CGFloat(percentage) * (geometry.size.width - 40) + 20))
    }
    
    private func widthForValue(geometry: GeometryProxy) -> CGFloat {
        return self.positionForValue(geometry: geometry)
    }
    
    private func valueForPosition(geometry: GeometryProxy, position: CGFloat) -> Double {
        let clampedPosition = max(0, min(geometry.size.width, position))
        let percentage = Double((clampedPosition - 20) / max(1, geometry.size.width - 40))
        return range.lowerBound + percentage * (range.upperBound - range.lowerBound)
    }
}

// Preview
struct WeightSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        WeightSelectionView()
    }
}
