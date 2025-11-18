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
      checksum: "0b4feca0b025b35f3449faf326c318739d857be48f1ec854c73e4ff3c3a692f1"
    )
  ]
)
