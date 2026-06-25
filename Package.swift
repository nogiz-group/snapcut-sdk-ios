// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "snapcut",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "snapcut",
            targets: ["snapcut"]),
    ],
    targets: [
        .binaryTarget(
            name: "snapcut",
            path: "snapcut.xcframework"
        )
    ]
)
