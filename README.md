# Object Detection App

This object detection app uses SwiftUI and Vision framework to display real-time object detection results on a live camera feed. The app allows users to enable/disable different object detection models and adjust the confidence threshold for displayed bounding boxes. The user interface includes a settings panel to configure these options.

## Features

- Real-time object detection on live camera feed
- Multiple object detection models (e.g., YOLOv7, custom models)
- Toggle individual models on/off
- Confidence threshold slider to filter out low-confidence detections
- Settings panel to configure detection settings

## Requirements

- iOS 13.0 or later
- Xcode 13.0 or later

## Installation
1. Clone this repository
```bash
git clone https://github.com/yourusername/object-detection-app.git
```
2. Open the project in Xcode:
```bash
cd object-detection-app
open ObjectDetectionApp.xcodeproj
```
3. Run the app on an iOS device or simulator.

## Usage

1. Grant camera access when prompted.
2. Enable/disable object detection models using the toggle buttons.
3. Adjust the confidence threshold using the slider.
4. Access additional settings by tapping the gear icon.

## Customization

To add custom object detection models:
1. Add the Core ML model (.mlmodelc) file to the project.
2. Update the PreviewState class with the new model name and default state (enabled/disabled).
3. Update the setupDetector(modelName: String) function in the ViewController class to handle the new model.

## License

This project is open-source and available under the MIT License.
