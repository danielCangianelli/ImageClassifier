import Foundation
import CoreML
import Vision
import UIKit

final class ImageClassifier {
    private let model: VNCoreMLModel

    init() {
        let config = MLModelConfiguration()
        config.computeUnits = .all 
        config.allowLowPrecisionAccumulationOnGPU = false
        guard let mlModel = try? MobileNetV2(configuration: config).model,
              let visionModel = try? VNCoreMLModel(for: mlModel) else {
            fatalError("Erro ao carregar o modelo MobileNetV2.")
        }
        self.model = visionModel
    }

    func classify(image: UIImage, completion: @escaping (String?) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }

        let request = VNCoreMLRequest(model: model) { request, _ in
            if let results = request.results as? [VNClassificationObservation],
               let bestResult = results.first(where: { $0.confidence > 0.5 }) {
                completion(bestResult.identifier)
            } else {
                completion(nil)
            }
        }

        let orientation = image.cgImageOrientation
        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: orientation, options: [:])

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                completion(nil)
            }
        }
    }
}

extension UIImage {
    var cgImageOrientation: CGImagePropertyOrientation {
        switch imageOrientation {
        case .up: return .up
        case .down: return .down
        case .left: return .left
        case .right: return .right
        case .upMirrored: return .upMirrored
        case .downMirrored: return .downMirrored
        case .leftMirrored: return .leftMirrored
        case .rightMirrored: return .rightMirrored
        @unknown default: return .up
        }
    }
}

