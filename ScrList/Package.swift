// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScrList",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ScrSearch",
            targets: ["ScrSearch"]),
        .library(
            name: "ScrDetail",
            targets: ["ScrDetail"]),
        .library(
            name: "ScrEntity",
            targets: ["ScrEntity"]),
    ],
    dependencies: [
        .package(name: "ModernRIBs", url: "https://github.com/DevYeom/ModernRIBs", .exact("1.0.1")),
        .package(path: "../Platform")
    ],
    targets: [
        .target(
            name: "ScrSearch",
            dependencies: [
                "ModernRIBs",
                .product(name: "ScrUI", package: "Platform")
            ]
        ),
        .target(
            name: "ScrDetail",
            dependencies: [
                "ModernRIBs"
            ]
        ),
        .target(
            name: "ScrEntity",
            dependencies: [
                
            ]
        ),
    ]
)
