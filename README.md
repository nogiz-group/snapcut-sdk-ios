# Snapcut SDK

Snapcut is a powerful iOS Video Editor SDK. 

## Installation

Add this repository via Swift Package Manager (SPM) in Xcode:
`File > Add Packages...` and enter the repository URL.

## Theming & Customization

The SDK comes with a powerful White-Label Theme Engine allowing you to customize colors and typography (fonts, sizes, weights) to match your app's branding perfectly.

### Customizing Colors

You can create a custom theme by modifying any property in `SDKTheme.colors`. 

```swift
import SwiftUI
import snapcut

// 1. Start with a default template (Light or Dark)
var myTheme = SDKTheme.defaultDark

// 2. Override specific colors using hex codes
myTheme.colors.accent = Color(hex: "#FFD700")       // e.g. Custom Yellow Accent
myTheme.colors.background = Color(hex: "#1A1A1A")   // App Background
myTheme.colors.surface = Color(hex: "#2C2C2C")      // Cards & Bottom Sheets
myTheme.colors.textPrimary = Color.white            // Main text
```

### Customizing Fonts (Size, Weight, Typeface)

By default, the SDK uses Apple's System Font (`SF Pro`). You can provide your own fonts, sizes, and weights by creating a struct that conforms to the `FontProvider` protocol. You simply return a `UIFont` for each typography style:

```swift
import UIKit
import snapcut

struct MyCustomFontProvider: FontProvider {
    func font(for style: SDKTypography.Style) -> UIFont {
        switch style {
        case .largeTitle: 
            return UIFont(name: "AvenirNext-Bold", size: 34) ?? .systemFont(ofSize: 34, weight: .bold)
        case .title: 
            return UIFont(name: "AvenirNext-Bold", size: 28) ?? .systemFont(ofSize: 28, weight: .bold)
        case .subtitle: 
            return UIFont(name: "AvenirNext-DemiBold", size: 22) ?? .systemFont(ofSize: 22, weight: .semibold)
        case .body: 
            return UIFont(name: "AvenirNext-Regular", size: 17) ?? .systemFont(ofSize: 17, weight: .regular)
        case .button: 
            return UIFont(name: "AvenirNext-DemiBold", size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        case .caption: 
            return UIFont(name: "AvenirNext-Medium", size: 12) ?? .systemFont(ofSize: 12, weight: .medium)
        case .label: 
            return UIFont(name: "AvenirNext-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular)
        case .timeline: 
            return UIFont(name: "AvenirNext-Bold", size: 10) ?? .systemFont(ofSize: 10, weight: .bold)
        case .toolbar: 
            return UIFont(name: "AvenirNext-Medium", size: 11) ?? .systemFont(ofSize: 11, weight: .medium)
        case .navigationTitle: 
            return UIFont(name: "AvenirNext-DemiBold", size: 17) ?? .systemFont(ofSize: 17, weight: .semibold)
        }
    }
}
```

Then assign it to your theme:
```swift
myTheme.typography.provider = MyCustomFontProvider()
```

## Usage & Initialization

Before using the SDK, initialize it with your license key and custom theme. A good place to do this is in your `App` struct or `AppDelegate`:

```swift
import SwiftUI
import snapcut

@main
struct TestSDKApp: App {
    init() {
        // 1. Define your custom theme & fonts
        var myTheme = SDKTheme.defaultDark
        myTheme.colors.accent = Color(hex: "#FFD700") 
        myTheme.typography.provider = MyCustomFontProvider()

        // 2. Initialize with configuration
        let config = VideoEditorConfiguration(
            licenseKey: "NOGIZ-SNAPCUT-PRO",
            darkTheme: myTheme
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
