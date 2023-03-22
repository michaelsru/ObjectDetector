import SwiftUI

struct ContentView: View {
    @StateObject private var previewState = PreviewState()

    var body: some View {
        VStack {
            HostedViewController(previewState: previewState)
                .ignoresSafeArea()

            Toggle("Preview", isOn: $previewState.isPreviewEnabled)
                .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
