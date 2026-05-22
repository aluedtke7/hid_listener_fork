// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "hid_listener",
    platforms: [
        .macOS("10.13"),
    ],
    products: [
        .library(name: "hid-listener", targets: ["hid_listener"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HidListenerShared",
            path: "Sources/HidListenerShared",
            publicHeadersPath: "include"
        ),
        .target(
            name: "hid_listener",
            dependencies: ["HidListenerShared"],
            path: "Sources/hid_listener",
            linkerSettings: [
                .linkedFramework("AppKit"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("Foundation"),
            ]
        ),
    ]
)
