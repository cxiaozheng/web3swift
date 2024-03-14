// swift-tools-version: 5.5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Web3swiftest",
    platforms: [
        .macOS(.v10_15), .iOS(.v13)
    ],
    products: [
        .library(name: "web3swiftest", targets: ["web3swiftest"])
    ],
    dependencies: [
        .package(url: "https://github.com/attaswift/BigInt.git", .upToNextMinor(from: "5.2.0")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "1.5.1")),
        .package(name: "secp256k1", url: "https://github.com/Boilertalk/secp256k1.swift.git", from: "0.1.7")
    ],
    targets: [
        .target(
            name: "Web3Core",
            dependencies: ["BigInt", "secp256k1", "CryptoSwift"]
        ),
        .target(
            name: "web3swiftest",
            dependencies: ["Web3Core", "BigInt", "secp256k1"],
            resources: [
                .copy("./Browser/browser.js"),
                .copy("./Browser/browser.min.js"),
                .copy("./Browser/wk.bridge.min.js")
            ]
        ),
        .testTarget(
            name: "localTests",
            dependencies: ["web3swiftest"],
            path: "Tests/web3swiftestTests/localTests",
            resources: [
                .copy("../../../TestToken/Helpers/SafeMath/SafeMath.sol"),
                .copy("../../../TestToken/Helpers/TokenBasics/ERC20.sol"),
                .copy("../../../TestToken/Helpers/TokenBasics/IERC20.sol"),
                .copy("../../../TestToken/Token/Web3SwiftToken.sol")
            ]
        ),
        .testTarget(
            name: "remoteTests",
            dependencies: ["web3swiftest"],
            path: "Tests/web3swiftestTests/remoteTests",
            resources: [
                .copy("../../../TestToken/Helpers/SafeMath/SafeMath.sol"),
                .copy("../../../TestToken/Helpers/TokenBasics/ERC20.sol"),
                .copy("../../../TestToken/Helpers/TokenBasics/IERC20.sol"),
                .copy("../../../TestToken/Token/Web3SwiftToken.sol")
            ]
        )
    ]
)
