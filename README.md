<!--
 README.md

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

<!--
 !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!!
 This file is managed by Workspace.
 Manual changes will not persist.
 For more information, see:
 https://github.com/SDGGiesbrecht/Workspace/blob/master/Documentation/Read‐Me.md
 !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!!
 -->

[🇨🇦EN](Documentation/🇨🇦EN%20Read%20Me.md) <!--Skip in Jazzy-->

APIs: [macOS](https://sdggiesbrecht.github.io/SDGMathematics/macOS) • [Linux](https://sdggiesbrecht.github.io/SDGMathematics/Linux) • [iOS](https://sdggiesbrecht.github.io/SDGMathematics/iOS) • [watchOS](https://sdggiesbrecht.github.io/SDGMathematics/watchOS) • [tvOS](https://sdggiesbrecht.github.io/SDGMathematics/tvOS)

# SDGMathematics

SDGMathematics extends support for mathematics.

> [מֹאזְנֵי מִרְמָה תּוֹעֲבַת יהוה וְאֶבֶן שְׁלֵמָה רְצוֹנוֹ׃<br>Deceptive scales are an abomination to the Lord; an accurate weight is his expectation.](https://www.biblegateway.com/passage/?search=Proverbs+11&version=WLC;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―‎שלמה/Shlomo

## Features

- Mathematical operations such as exponents, roots, logarithms, and trigonometry.
- Arbitrary‐precision number types: `WholeNumber`, `Integer` & `RationalNumber`.
- Customizable randomization of numbers and boolean values.
- A hierarchical protocol model for number types: `WholeArithmetic`, `IntegralArithmetic`, `RationalArithmetic`, `RealArithmetic`, etc.
- A `Measurement` protocol to simplify working with differing units.
- Automated reversal of complex functions via `findLocalMinimum(near:within:inFunction)`, etc.

(For a list of related projecs, see [here](Documentation/🇨🇦EN%20Related%20Projects.md).) <!--Skip in Jazzy-->

## Importing

SDGMathematics is intended for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGMathematics as a dependency in `Package.swift`:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .Package(url: "https://github.com/SDGGiesbrecht/SDGMathematics", versions: "1.0.2" ..< "2.0.0"),
        ...
    ]
)
```

SDGMathematics can then be imported in source files:

```swift
import SDGMathematics
```

## Example Usage

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

func analyzeParabola() {
    let parabola: (Int) -> Int = {
        (x: Int) -> Int in
        return 2 × x↑2   +   4 × x   −   1
    }
    let vertexX = findLocalMinimum(near: 0, inFunction: parabola)
    print("The vertex is at (\( vertexX ), \( parabola(vertexX) )).")
}
```

## About

The SDGMathematics project is maintained by Jeremy David Giesbrecht.

If SDGMathematics saves you money, consider giving some of it as a [donation](https://paypal.me/JeremyGiesbrecht).

If SDGMathematics saves you time, consider devoting some of it to [contributing](https://github.com/SDGGiesbrecht/SDGMathematics) back to the project.

> [Ἄξιος γὰρ ὁ ἐργάτης τοῦ μισθοῦ αὐτοῦ ἐστι.<br>For the worker is worthy of his wages.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―‎ישוע/Yeshuʼa
