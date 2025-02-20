// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DuckWorksEngineSDK",
    platforms: [
        .iOS(.v14) 
    ], products: [
        .library(
            name: "DuckWorksEngineSDK",
            targets: ["DuckWorksEngineSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/AppsFlyerSDK/AppsFlyerFramework-Static", from: "6.15.3"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.0")),
    ],
    targets: [
        .target(
            name: "DuckWorksEngineSDK",
            dependencies: [
                .product(name: "AppsFlyerLib-Static", package: "AppsFlyerFramework-Static"),
                .product(name: "Alamofire", package: "Alamofire"),
            ]),
        .testTarget(
            name: "DuckWorksEngineSDKTests",
            dependencies: ["DuckWorksEngineSDK"]),
    ]
)
