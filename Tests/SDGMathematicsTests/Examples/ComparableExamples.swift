/*
 ComparableExamples.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

private func demonstrateSetLessThan() {

    func rollDie() -> Int {
        fatalError()
    }

    // [_Define Example: ≤=_]
    let numberOfRolls = 5
    var lowestRoll = 6
    for _ in 1 ... numberOfRolls {
        lowestRoll ≤= rollDie()
    }
    print("After rolling the die \(numberOfRolls) time(s), the lowest roll was \(lowestRoll).")
    // Prints, for example, “After rolling the die 5 time(s), the lowest roll was 2.”
    // [_End_]
}

private func demonstrateSetGreaterThan() {

    func rollDie() -> Int {
        fatalError()
    }

    // [_Define Example: ≥=_]
    let numberOfRolls = 5
    var highestRoll = 1
    for _ in 1 ... numberOfRolls {
        highestRoll ≥= rollDie()
    }
    print("After rolling the die \(numberOfRolls) time(s), the highest roll was \(highestRoll).")
    // Prints, for example, “After rolling the die 5 time(s), the highest roll was 4.”
    // [_End_]
}
