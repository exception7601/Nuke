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
      checksum: "bfde2d4f75dd82a7e6ad7f3c4553147c165adef402d672880d826b820fe790c0"
    )
  ]
)
