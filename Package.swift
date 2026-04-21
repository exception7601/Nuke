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
      url: "https://github.com/exception7601/Nuke/releases/download/13.0.2/nuke-1248465fc4e41ee2.zip",
      checksum: "8007e524508244dbbe0fbf85a4c8652f9f7678af2d43e0145b4ab1a44a860935"
    )
  ]
)
