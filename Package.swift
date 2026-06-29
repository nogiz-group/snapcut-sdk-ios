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
        .package(url: "https://github.com/Giphy/giphy-ios-sdk", exact: "2.3.2"),
        .package(url: "https://github.com/SDWebImage/libwebp-Xcode", exact: "1.5.0")
    ],
    targets: [
        .target(
            name: "snapcutWrapper",
            dependencies: [
                .target(name: "snapcut"),
                .product(name: "GiphyUISDK", package: "giphy-ios-sdk"),
                .product(name: "libwebp", package: "libwebp-Xcode")
            ],
            path: "Sources/snapcutWrapper"
        ),
        .binaryTarget(
            name: "snapcut",
            path: "snapcut.xcframework"
        )
    ]
)
