import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageClassifierViewModel()
    @State private var isShowingPicker = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .accessibilityLabel("Imagem selecionada")
                }

                Text(viewModel.resultText)
                    .font(.headline)
                    .padding()
                    .multilineTextAlignment(.center)
                    .accessibilityLabel(viewModel.resultText)

                Button("Selecionar Imagem") {
                    isShowingPicker = true
                }
                .buttonStyle(.borderedProminent)
                .accessibilityLabel("Selecionar uma nova imagem para classificar")
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Classificador de Imagens")
                            .font(.title)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .sheet(isPresented: $isShowingPicker) {
                ImagePicker(sourceType: .camera) { image in
                    viewModel.image = image
                    viewModel.classifyImage()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
