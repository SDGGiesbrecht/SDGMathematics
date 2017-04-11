/*
 Integer.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// An arbitrary‐precision integer.
public struct Integer : Addable, Equatable, Subtractable {

    // [_Warning: Temporary_]
    public static let one = Integer(magnitude: 1, isNegative: false)
    public static let two = Integer(magnitude: 1, isNegative: false)
    public static let three = Integer(magnitude: 1, isNegative: false)

    // MARK: - Properties

    private var magnitude: WholeNumber
    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isNegative_]
    public private(set) var isNegative: Bool

    // MARK: - Normalization

    private mutating func normalize() {
        if isNegative ∧ magnitude == 0 {
            isNegative = false
        }
    }

    // MARK: - Addable

    // [_Inherit Documentation: SDGMathematics.Addable.+=_]
    public static func += (lhs: inout Integer, rhs: Integer) {
        if lhs.isNegative == rhs.isNegative {
            // Moving away from zero.
            lhs.magnitude += rhs.magnitude
        } else {
            // Approaching zero...
            if lhs.magnitude ≥ rhs.magnitude {
                // ...but stopping short of it.
                lhs.magnitude −= rhs.magnitude
            } else {
                // ...and crossing it.
                lhs.magnitude = rhs.magnitude − lhs.magnitude
                lhs.isNegative¬=
            }
        }

        lhs.normalize()
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGLogic.Equatable.==_]
    public static func == (lhs: Integer, rhs: Integer) -> Bool {
        return (lhs.isNegative, lhs.magnitude) == (rhs.isNegative, rhs.magnitude)
    }

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGMathematics.Subtractable.−=_]
    public static func −= (lhs: inout Integer, rhs: Integer) {
        // [_Warning: Awaiting Negatable._]
        fatalError()
    }
}
