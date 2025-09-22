// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Nuke",
  platforms: [.iOS(.v12)],
  products: [
    .library(
      name: "Nuke",
      targets: [
        "Nuke",
      ]
    ),
  ],

  targets: [
    .binaryTarget(
      name: "Nuke",
      url: "https://github.com/exception7601/Nuke/releases/download/12.8.0/nuke-iOS-8cff9120de35fde1.zip",
      checksum: "c205d1ab0cc291b4172fcbb1ef807ec314f31911b805dd8b728da2d3400834bd"
    )
  ]
)
