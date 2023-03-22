import Vision
import AVFoundation
import UIKit

extension ViewController {
    
    func setupDetector() {
//        let modelURL = Bundle.main.url(forResource: "YOLOv3TinyInt8LUT", withExtension: "mlmodelc")
        let modelURL = Bundle.main.url(forResource: "doors_stairs", withExtension: "mlmodelc")
    
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL!))
            let recognitions = VNCoreMLRequest(model: visionModel, completionHandler: detectionDidComplete)
            self.requests = [recognitions]
        } catch let error {
            print(error)
        }
    }
    
    func detectionDidComplete(request: VNRequest, error: Error?) {
        DispatchQueue.main.async(execute: {
            if let results = request.results {
                self.extractDetections(results)
            }
        })
    }

    func extractDetections(_ results: [VNObservation]) {
//        print("Extract Detections")
        detectionLayer.sublayers = nil

        for observation in results where observation is VNRecognizedObjectObservation {
            print("observation")
            guard let objectObservation = observation as? VNRecognizedObjectObservation else { continue }
            
            // Transformations
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(screenRect.size.width), Int(screenRect.size.height))
            print("id:\(objectObservation.labels[0].identifier) confidence:\(objectObservation.confidence) (\(round(objectBounds.minX)), \(round(objectBounds.minY))), (\(round(objectBounds.maxX)), \(round(objectBounds.maxY)))")
            let transformedBounds = CGRect(x: objectBounds.minX, y: screenRect.size.height - objectBounds.maxY, width: objectBounds.maxX - objectBounds.minX, height: objectBounds.maxY - objectBounds.minY)
            
            let boxLayer = self.drawBoundingBox(transformedBounds)

            detectionLayer.addSublayer(boxLayer)

            // Draw text label with confidence level
            let labelText = "\(objectObservation.labels[0].identifier) \(String(format: "%.2f", objectObservation.confidence))"
            let textLayer = self.drawTextLayer(bounds: transformedBounds, labelText: labelText)
            detectionLayer.addSublayer(textLayer)
        }
    }

    func setupLayers() {
        detectionLayer = CALayer()
        detectionLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        DispatchQueue.main.async { [weak self] in
            self!.view.layer.addSublayer(self!.detectionLayer)
        }
    }

    func updateLayers() {
        detectionLayer?.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
    }

    func drawBoundingBox(_ bounds: CGRect) -> CALayer {
        let boxLayer = CALayer()
        boxLayer.frame = bounds
        boxLayer.borderWidth = 3.0
        boxLayer.borderColor = CGColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        boxLayer.cornerRadius = 4
        return boxLayer
    }

    func drawTextLayer(bounds: CGRect, labelText: String) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.string = labelText
        textLayer.fontSize = 11
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
        textLayer.cornerRadius = 4
        textLayer.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y - 20, width: bounds.size.width, height: 20)
        return textLayer
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:]) // Create handler to perform request on the buffer

        do {
            try imageRequestHandler.perform(self.requests) // Schedules vision requests to be performed
        } catch {
            print(error)
        }
    }
}
