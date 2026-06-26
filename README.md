# Snapcut SDK

Snapcut is a powerful iOS Video Editor SDK. 

## Installation

Add this repository via Swift Package Manager (SPM) in Xcode:
`File > Add Packages...` and enter the repository URL.

## Usage

Before using the SDK, you must initialize it with your license key. A good place to do this is in your `App` struct or `AppDelegate`:

```swift
import SwiftUI
import snapcut

@main
struct TestSDKApp: App {
    init() {
        // 1. Create a custom theme (Optional)
        var myTheme = SDKTheme.defaultDark
        myTheme.colors.accent = Color(hex: "#FFD700") // Custom yellow

        // 2. Initialize with configuration
        let config = VideoEditorConfiguration(
            licenseKey: "NOGIZ-SNAPCUT-PRO",
            theme: .custom(myTheme)
        )
        SnapcutSDK.initialize(config: config)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

You have two choices for integrating the editor UI:

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
