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
      url: "https://github.com/exception7601/Nuke/releases/download/13.0.4/nuke-2c5f7a3ccac66ae7.zip",
      checksum: "d928bbed52903d221190947974c9f57957c74f0bd7616a278c6d77ad7e42fd4a"
    )
  ]
)
