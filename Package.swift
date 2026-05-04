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
      checksum: "5ca3d1172fe0d8ef7223ae5e73f19cdeb2218a159ec5f90a7b3df12515644e3f"
    )
  ]
)
