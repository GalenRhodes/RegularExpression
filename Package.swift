// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

//@f:0
let package = Package(
  name: "RegularExpression",
  platforms: [ .macOS(.v10_15), .tvOS(.v13), .iOS(.v13), .watchOS(.v6) ],
  products: [
      .library(name: "RegularExpression", targets: [ "RegularExpression" ]),
  ],
  dependencies: [],
  targets: [
      .target(name: "RegularExpression", dependencies: [], exclude: [ "Info.plist" ]),
      .testTarget(name: "RegularExpressionTests", dependencies: [ "RegularExpression" ], exclude: [ "Info.plist" ]),
  ]
)
//@f:1
