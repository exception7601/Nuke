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
      checksum: "43627ff1eca7c5a34a445a92dfec99d4c76547b9ff4412e59192c69416f5f820"
    )
  ]
)
