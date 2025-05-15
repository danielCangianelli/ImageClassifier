# 📘 BERT Metadata Viewer

Aplicativo iOS desenvolvido em **Swift 5.9** e **SwiftUI**, que carrega o modelo Core ML `BERTSQUADFP16.mlmodel` e exibe o nome do autor definido nos metadados do modelo. O projeto segue a arquitetura **MVVM**, adotando boas práticas de acessibilidade.

---

## 🧰 Tecnologias Utilizadas

- Swift 6 
- SwiftUI
- Core ML  
- MVVM    

---

## 📦 Estrutura do Projeto
```text
BERTMetadataViewer/
├── Models/
│ └── ModelError.swift
├── Services/
│ └── ModelMetadataService.swift
├── ViewModels/
│ └── ModelViewModel.swift
├── Views/
│ └── ContentView.swift
├── Resources/
│ └── BERTSQUADFP16.mlmodel
├── BERTMetadataViewerApp.swift
└── README.md
