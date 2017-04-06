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

private func demonstrateDecrease() {

    func rollDie() -> Int {
        fatalError()
    }

    // [_Define Example: decrease(to:)_]
    let numberOfRolls = 5
    var lowestRoll = 6
    for _ in 1 ... numberOfRolls {
        lowestRoll.decrease(to: rollDie())
    }
    print("After rolling the die \(numberOfRolls) time(s), the lowest roll was \(lowestRoll).")
    // Prints, for example, “After rolling the die 5 time(s), the lowest roll was 2.”

    // In this example, rollDie() represents a function that randomly returns an Int between 1 and 6 inclusive. In each iteration of the for loop, a new random number is generated, and if it is less than lowestRoll’s existing value, decrease(to:) changes lowestRoll to reflect the new low.
    // [_End_]
}

private func demonstrateincrease() {

    func rollDie() -> Int {
        fatalError()
    }

    // [_Define Example: increase(to:)_]
    let numberOfRolls = 5
    var highestRoll = 1
    for _ in 1 ... numberOfRolls {
        highestRoll.increase(to: rollDie())
    }
    print("After rolling the die \(numberOfRolls) time(s), the highest roll was \(highestRoll).")
    // Prints, for example, “After rolling the die 5 time(s), the highest roll was 4.”

    // In this example, rollDie() represents a function that randomly returns an Int between 1 and 6 inclusive. In each iteration of the for loop, a new random number is generated, and if it is greater than highestRoll’s existing value, increase(to:) changes highestRoll to reflect the new high.
    // [_End_]
}
