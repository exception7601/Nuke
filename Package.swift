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
      checksum: "6558f3fd9c1885724204f9cb958216fb112b1fa76c5522041504a2e3f2e039e6"
    )
  ]
)
