/*
 WholeNumberType.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A type which *only ever* represents whole numbers.
///
/// Conformance Requirements:
///
/// - `WholeArithmetic`
public protocol WholeNumberType : WholeArithmetic {

}

extension WholeNumberType {

    public init(_ representation: String, digitSet: [Set<UnicodeScalar>]) {
        let base = Self(UIntMax(digitSet.count))
        var mapping: [UnicodeScalar: Self] = [:]
        for value in digitSet.indices {
            let characters = digitSet[value]
            for character in characters {
                mapping[character] = Self(UIntMax(value))
            }
        }

        self = 0
        var position: Self = 0
        for character in representation.decomposedStringWithCompatibilityMapping.unicodeScalars.reversed() {
            if let digit = mapping[character] {
                self += (base ↑ position) × digit
                position += 1
            }
        }
    }
}
