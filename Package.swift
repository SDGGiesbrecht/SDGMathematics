import PackageDescription

let package = Package(
    name: "SDGMathematics",
    dependencies: [
        .Package(url: "https://github.com/SDGGiesbrecht/SDGLogic", versions: "1.1.0" ..< "2.0.0")
    ]
)
