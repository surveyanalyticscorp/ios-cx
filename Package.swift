// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "QuestionProCXFramework",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "QuestionProCXFramework",
            targets: ["QuestionProCXFramework"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "QuestionProCXFramework",
            path: "QuestionProCXFramework.xcframework"
        )
    ]
)
