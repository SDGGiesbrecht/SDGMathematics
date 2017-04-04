/*
 ReadMe.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Define Example: Read‐Me: en-CA_]
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
// [_End_]
