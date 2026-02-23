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
      url: "https://github.com/exception7601/Nuke/releases/download/12.9.0/nuke-83e19143355b02e9.zip",
      checksum: "5b3d355b3a5963fb1f4a45ad960eb36fb760c2bf1f60a01bf485357210a2fcd0"
    )
  ]
)
