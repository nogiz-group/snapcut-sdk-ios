# Snapcut SDK

Snapcut is a powerful iOS Video Editor SDK. 

## Installation

Add this repository via Swift Package Manager (SPM) in Xcode:
`File > Add Packages...` and enter the repository URL.

## Usage

You have two choices for integrating the SDK:

### 1. Full Integration (with Video Picker & Camera)
If you want the complete experience (including the built-in video recorder and library picker), use `SnapcutMainView`.

```swift
import SwiftUI
import snapcut

struct ContentView: View {
    var body: some View {
        SnapcutMainView()
            .ignoresSafeArea()
    }
}
```

### 2. Custom Integration (Editor Only)
If you already have your own video picking logic and just want to launch the editor with a specific video file URL, use `EditorView`.

```swift
import SwiftUI
import snapcut

struct ContentView: View {
    @StateObject private var editorViewModel: EditorViewModel
    
    init() {
        // Pass your own local video URL here
        let url = URL(fileURLWithPath: "/path/to/video.mp4")
        _editorViewModel = StateObject(wrappedValue: EditorViewModel(videoURL: url))
    }

    var body: some View {
        EditorView(
            viewModel: editorViewModel,
            onImportVideo: { newURL in
                print("Imported new video: \(newURL)")
            },
            onDismiss: {
                print("Editor dismissed")
            }
        )
    }
}
```
