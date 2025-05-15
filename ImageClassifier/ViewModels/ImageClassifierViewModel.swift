import SwiftUI

final class ImageClassifierViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var resultText: String = "Selecione uma imagem"
    private let classifier = ImageClassifier()

    func classifyImage() {
        guard let image = image else { return }

        resultText = "Analisando imagem..."
        classifier.classify(image: image) { [weak self] result in
            DispatchQueue.main.async {
                self?.resultText = result.map { "Resultado: \($0.capitalized)" } ?? "Nenhum resultado encontrado"
            }
        }
    }
}
