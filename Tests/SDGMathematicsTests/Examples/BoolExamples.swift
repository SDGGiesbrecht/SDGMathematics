/*
 BoolExamples.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

func demonstrateAlternatingBooleans() {
    // [_Define Example: Alternating Booleans_]
    let alternating = CyclicalNumberGenerator([
        Bool.falseRandomizerValue,
        Bool.trueRandomizerValue
        ])

    // Booleans created using...
    _ = Bool(fromRandomizer: alternating)
    // ...now alternate between “false” and “true”.
    // [_End_]
}
