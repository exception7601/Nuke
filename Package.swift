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
      url: "https://github.com/exception7601/Nuke/releases/download/13.0.1/nuke-76e780ad7100c224.zip",
      checksum: "9796ec5fe4b1e8977362bef74e9d6f8ac3354e16ace7114fc53907881eefc11e"
    )
  ]
)
