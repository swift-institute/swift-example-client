// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-example-client",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Example Client",
            targets: ["Example Client"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-either.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-operation.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-coder.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-tagged.git", branch: "main"),
        .package(url: "https://github.com/swift-molecules/swift-tagged-coder.git", branch: "main"),
        .package(url: "https://github.com/swift-institute/swift-example.git", branch: "main"),
        .package(url: "https://github.com/swift-institute/swift-example-signature.git", branch: "main"),
        .package(url: "https://github.com/swift-institute/swift-example-http.git", branch: "main"),
        .package(url: "https://github.com/swift-standards/swift-http.git", branch: "main"),
        .package(url: "https://github.com/swift-compositions/swift-http-router.git", branch: "main"),
        .package(url: "https://github.com/swift-compositions/swift-http-client.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Example Client",
            dependencies: [
                .product(name: "Coder", package: "swift-coder"),
                .product(name: "Tagged Coder", package: "swift-tagged-coder"),
                .product(name: "Example", package: "swift-example"),
                .product(name: "Example Greeting", package: "swift-example"),
                .product(name: "Example Counter", package: "swift-example"),
                .product(name: "Example Signature", package: "swift-example-signature"),
                .product(name: "Example Greeting Signature", package: "swift-example-signature"),
                .product(name: "Example Counter Signature", package: "swift-example-signature"),
                .product(name: "Example HTTP", package: "swift-example-http"),
                .product(name: "HTTP", package: "swift-http"),
                .product(name: "HTTP Reply", package: "swift-http-router"),
                .product(name: "HTTP Client", package: "swift-http-client"),
            ]
        ),
        .testTarget(
            name: "Example Client Tests",
            dependencies: [
                .product(name: "Operation", package: "swift-operation"),
                "Example Client",
                .product(name: "Coder", package: "swift-coder"),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Example", package: "swift-example"),
                .product(name: "Example Greeting", package: "swift-example"),
                .product(name: "Example Counter", package: "swift-example"),
                .product(name: "Example Signature", package: "swift-example-signature"),
                .product(name: "Example Greeting Signature", package: "swift-example-signature"),
                .product(name: "Example Counter Signature", package: "swift-example-signature"),
                .product(name: "Example HTTP", package: "swift-example-http"),
                .product(name: "HTTP", package: "swift-http"),
                .product(name: "HTTP Router", package: "swift-http-router"),
                .product(name: "HTTP Reply", package: "swift-http-router"),
                .product(name: "HTTP Client", package: "swift-http-client"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Tagged Coder", package: "swift-tagged-coder"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
