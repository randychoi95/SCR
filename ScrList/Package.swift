// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScrList",
    platforms: [.iOS(.v14)],
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
        .library(
            name: "ScrRepository",
            targets: ["ScrRepository"]),
        .library(
            name: "InventoryEntity",
            targets: ["InventoryEntity"]),
        .library(
            name: "InventoryRepository",
            targets: ["InventoryRepository"]),
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
                "ScrRepository",
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
        .target(
            name: "ScrRepository",
            dependencies: [
                "ScrEntity",
                .product(name: "Network", package: "Platform"),
                .product(name: "CombineUtil", package: "Platform")
            ]
        ),
        .target(
            name: "InventoryEntity",
            dependencies: [
                
            ]
        ),
        .target(
            name: "InventoryRepository",
            dependencies: [
                "InventoryEntity",
                .product(name: "Network", package: "Platform"),
                .product(name: "CombineUtil", package: "Platform")
            ]
        ),
    ]
)
