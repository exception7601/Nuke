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
      url: "https://github.com/exception7601/Nuke/releases/download/12.8.3/nuke-0ead44350d2737db.zip",
      checksum: "6da5cfbbe4ca5eccb1dffba8695b06e8530c14a1baaaf1f61b5df014bb415d54"
    )
  ]
)
