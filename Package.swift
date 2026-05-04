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
      url: "https://github.com/exception7601/Nuke/releases/download/13.0.5/nuke-4a3dd00de49cb253.zip",
      checksum: "b98591726f6e2acd4abbdb06e031badcdd34232e2c2c115e594f8593188816d6"
    )
  ]
)
