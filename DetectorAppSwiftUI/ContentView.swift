import SwiftUI

struct ContentView: View {
    @StateObject private var previewState = PreviewState()

    var body: some View {
        VStack {
            Text("Model: " + previewState.models.keys.sorted().joined(separator:", "))
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .padding(.top, 10)
            HostedViewController(previewState: previewState)
                .ignoresSafeArea()

            Toggle("Preview", isOn: $previewState.isPreviewEnabled)
                .padding()

            ForEach(Array(previewState.models.keys.sorted()), id: \.self) { modelName in
                Toggle("Detect \(modelName)", isOn: Binding<Bool>(
                                    get: { previewState.models[modelName] ?? false },
                                    set: { newValue in previewState.models[modelName] = newValue }
                                ))
                    .padding()
            }

            HStack {
                Text("Confidence Threshold: \(previewState.confidenceThreshold, specifier: "%.2f")")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .padding(.trailing, 8)

                Slider(value: $previewState.confidenceThreshold, in: 0...1)
            }
            .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
