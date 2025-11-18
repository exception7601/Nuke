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
      url: "https://github.com/exception7601/Nuke/releases/download/12.8.2/nuke-0ead44350d2737db.zip",
      checksum: "693c8a4624d33c22cbfc26b6d45809aca2fcad09e658e1312365eaf04c54a8d7"
    )
  ]
)
