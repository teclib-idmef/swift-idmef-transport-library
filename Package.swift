// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IDMEFTransport",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "IDMEFTransport",targets: ["IDMEFTransport"]),
        .executable(name: "IDMEFServerExecutable", targets: ["IDMEFServerExecutable"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/teclib-idmef/swift-idmef-library", .branch("main")),
        .package(url: "https://github.com/envoy/Embassy.git", from: "4.1.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "IDMEFTransport",
            dependencies: [
                .product(name: "IDMEF", package: "swift-idmef-library"),
                .product(name: "Embassy", package: "Embassy"),
                ]),
        .executableTarget(
            name: "IDMEFServerExecutable",
            dependencies: [
                .product(name: "IDMEF", package: "swift-idmef-library"),
                .product(name: "Embassy", package: "Embassy"),
                "IDMEFTransport"
                ]),

        .testTarget(
            name: "IDMEFTransportTests",
            dependencies: ["IDMEFTransport"]),
    ]
)
