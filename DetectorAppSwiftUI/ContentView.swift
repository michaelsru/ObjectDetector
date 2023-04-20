import SwiftUI

struct ContentView: View {
    @StateObject private var previewState = PreviewState()

    var body: some View {
        VStack {
            Text("Model: " + previewState.modelName.joined(separator:", "))
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .padding(.top, 10)
            HostedViewController(previewState: previewState)
                .ignoresSafeArea()

            Toggle("Preview", isOn: $previewState.isPreviewEnabled)
                .padding()
            Toggle("Detect COCO", isOn: $previewState.isYolov7Enabled)
                .padding()
            Toggle("Detect doors", isOn: $previewState.isBestModelEnabled)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
