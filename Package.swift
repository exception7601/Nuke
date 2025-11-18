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
      url: "https://github.com/exception7601/Nuke/releases/download/12.8.1/nuke-0ead44350d2737db.zip",
      checksum: "9205d6640f41bf74112f700ee1329ecbc2c8703fc8a73a4af4e2735454552bec"
    )
  ]
)
