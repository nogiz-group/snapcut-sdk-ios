// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "snapcut",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "snapcut",
            targets: ["snapcutWrapper"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Giphy/giphy-ios-sdk.git", exact: "2.3.2"),
        .package(url: "https://github.com/SDWebImage/libwebp-Xcode.git", exact: "1.5.0"),
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", from: "0.9.0"),
        .package(url: "https://github.com/ggerganov/whisper.spm.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "snapcutWrapper",
            dependencies: [
                .target(name: "snapcut"),
                .product(name: "GiphyUISDK", package: "giphy-ios-sdk"),
                .product(name: "libwebp", package: "libwebp-Xcode"),
                .product(name: "ZIPFoundation", package: "ZIPFoundation"),
                .product(name: "whisper", package: "whisper.spm")
            ],
            path: "Sources/snapcutWrapper"
        ),
        .binaryTarget(
            name: "snapcut",
            path: "snapcut.xcframework"
        )
    ]
)
