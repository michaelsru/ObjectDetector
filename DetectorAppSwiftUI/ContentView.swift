import SwiftUI

struct ContentView: View {
    @StateObject private var previewState = PreviewState()
    @State private var showSettings = false

    var body: some View {
        VStack {
            Text("Model: " + previewState.models.keys.sorted().joined(separator:", "))
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .padding(.top, 10)

            HostedViewController(previewState: previewState)
                .ignoresSafeArea()

            Toggle("Preview", isOn: $previewState.isPreviewEnabled)
                .padding()

            Button(action: { showSettings.toggle() }) {
                Image(systemName: "gearshape")
                    .font(.system(size: 24))
                    .padding()
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(previewState: previewState)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
