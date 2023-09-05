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
      url: "https://github.com/exception7601/Nuke/releases/download/12.8.0/nuke-0ead44350d2737db.zip",
      checksum: "9fbf75d2c37dfabdf98eb1141b2c69a616ff81abb6c17625d11fde7ce84e8759"
    )
  ]
)
