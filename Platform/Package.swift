// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ScrUI",
            targets: ["ScrUI"]),
        .library(
            name: "RIBsUtil",
            targets: ["RIBsUtil"]),
        .library(
            name: "Network",
            targets: ["Network"]),
        .library(
            name: "NetworkImp",
            targets: ["NetworkImp"]),
    ],
    dependencies: [
        .package(name: "ModernRIBs", url: "https://github.com/DevYeom/ModernRIBs", .exact("1.0.1")),

    ],
    targets: [
        .target(
            name: "ScrUI",
            dependencies: [
                "ModernRIBs",
            ]),
        .target(
            name: "RIBsUtil",
            dependencies: [
                "ModernRIBs",
            ]),
        .target(
            name: "Network",
            dependencies: [
                
            ]),
        .target(
            name: "NetworkImp",
            dependencies: [
                "Network"
            ]),
    ]
)
