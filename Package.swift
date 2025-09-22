// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Nuke",
  platforms: [.iOS(.v12)],
  products: [
    .library(
      name: "Nuke",
      targets: [
        "Sentry",
      ]
    ),
  ],

  targets: [
    .binaryTarget(
      name: "Nuke",
      url: "https://github.com/exception7601/Nuke/releases/download/12.8.0/nuke-iOS-89d4a5921c91dd21.zip",
      checksum: "e9e7a69a8b2bc0585d5624996c8b15cd8e0be601bc60d10d1b0cd148bc0697bc"
    )
  ]
)
