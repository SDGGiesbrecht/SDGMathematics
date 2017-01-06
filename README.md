<!-- README.md -->
<!--  -->
<!-- This source file is part of the SDGMathematics open source project. -->
<!--  -->
<!-- Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors. -->
<!--  -->
<!-- Soli Deo gloria -->
<!--  -->
<!-- Licensed under the Apache License, Version 2.0 -->
<!-- See http://www.apache.org/licenses/LICENSE-2.0 for licence information. -->

# SDGMathematics

SDGMathematics extends support for mathematics.

## SDGMathematics provides:

* A hierarchical protocol model for number types: `WholeArithmetic`, `IntegralArithmetic`, `RationalArithmetic`, `RealArithmetic`, etc.
* Mathematical operations such as exponents, roots, logarithms, and trigonometry.
* Customizable randomization of numbers and boolean values.
* A `Measurement` protocol to simplify working with differing units.
* Automated reversal of complex functions via `findLocalMinimum(near:within:inFunction)`, etc.
* Operators: −, ×, ÷, etc.

(For a list of other modules in the SDG family, see [here](https://github.com/SDGGiesbrecht/SDG/blob/master/README.md).)

## Platform differences:

The extensions to `CGFloat` are not available on Linux.

## Importing

SDGMathematics is intended for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGMathematics as a dependency in `Package.swift`:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .Package(url: "https://github.com/SDGGiesbrecht/SDGMathematics", versions: "1.0.1" ..< "2.0.0")
    ]
)
```

SDGMathematics can then be imported in source files:

```swift
import SDGMathematics
```

## Usage Examples

```swift
import SDGLogic
import SDGMathematics

func verifyPythagoreanTheorem() {
    let a = 3.0
    let b = 4.0
    let c = 5.0
    if √(a↑2 + b↑2) ≠ c {
        print("Pythagoras was wrong! (Or maybe I just need to research floating point numbers...)")
    }
}

func tryTrigonometry() {
    let θ = 90.0°
    let sine = sin(θ)
    print("The sine of \(θ.inRadians) radians is \(sine)")
}

func playWithDice() {

    func rollDie() -> Int {
        return Int(randomInRange: 1 ... 6)
    }

    if rollDie() == 1 ∧ rollDie() == 1 {
        print("Snake eyes!")
    } else {
        print("Not this time...")
    }
}

func analyseParabola() {
    let parabola: (Int) -> Int = {
        (x: Int) -> Int in
        return 2 × x↑2   +   4 × x   −   1
    }
    let vertexX = findLocalMinimum(near: 0, inFunction: parabola)
    print("The vertex is at (\( vertexX ), \( parabola(vertexX) )).")
}
```

## Documentation:

Complete API documentation is available [here](https://sdggiesbrecht.github.io/SDGMathematics/).
