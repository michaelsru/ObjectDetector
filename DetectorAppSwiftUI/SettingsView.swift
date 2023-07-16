//
//  SettingsView.swift
//  DetectorAppSwiftUI
//
//  Created by Michael Ru on 2023-04-19.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var previewState: PreviewState

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Models")
                    ForEach(Array(previewState.models.keys.sorted()), id: \.self) { modelName in
                        Toggle("\(modelName)", isOn: Binding<Bool>(
                                get: { previewState.models[modelName] ?? false },
                                set: { newValue in previewState.models[modelName] = newValue }
                            ))
                        .padding()
                    }
                }

                HStack {
                    Text("Confidence Threshold: \(previewState.confidenceThreshold, specifier: "%.2f")")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .padding(.trailing, 8)

                    Slider(value: $previewState.confidenceThreshold, in: 0...1)
                }
                .padding()

            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done", action: { presentationMode.wrappedValue.dismiss() }))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(previewState: PreviewState())
    }
}
