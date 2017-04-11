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

/// A typealias for disambiguating the `SDGMathematics.Integer` type from the `Swift.Integer` protocol when necessary.
public typealias ArbitraryPrecisionInteger = Integer

/// An arbitrary‐precision integer.
///
/// The typealias `ArbitraryPrecisionInteger` is available when disambiguation is necessary.
public struct Integer : Addable, Equatable, ExpressibleByIntegerLiteral, Negatable, Subtractable {

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

    // MARK: - ExpressibleByIntegerLiteral

    public typealias IntegerLiteralType = IntMax

    public init(integerLiteral: IntegerLiteralType) {

        isNegative = integerLiteral.isNegative

        let whole = UIntMax(|integerLiteral|)
        magnitude = WholeNumber(whole)

        normalize()
    }

    // MARK: - Negatable

    // [_Inherit Documentation: SDGMathematics.Negatable.−=_]
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout Integer) {
        operand.isNegative¬=
    }

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGMathematics.Subtractable.−=_]
    public static func −= (lhs: inout Integer, rhs: Integer) {
        lhs += −rhs
    }
}
