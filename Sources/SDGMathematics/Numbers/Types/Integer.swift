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
public struct Integer : Addable, Comparable, Equatable, ExpressibleByIntegerLiteral, IntegerType, Negatable, PointType, Subtractable, WholeArithmetic {

    // MARK: - Initialization

    private init(magnitude: WholeNumber, isNegative: Bool) {
        self.definition = Definition(magnitude: magnitude, isNegative: isNegative)
    }

    public init(_ wholeNumber: WholeNumber) {
        self.init(magnitude: wholeNumber, isNegative: false)
    }

    // MARK: - Properties

    private struct Definition {
        fileprivate var magnitude: WholeNumber
        fileprivate var isNegative: Bool
    }
    private var unsafeDefinition = Definition(magnitude: 0, isNegative: false)
    private var definition: Definition {
        get {
            return unsafeDefinition
        }
        set {
            unsafeDefinition = newValue

            // Normalize

            if unsafeDefinition.isNegative ∧ unsafeDefinition.magnitude == 0 {
                unsafeDefinition.isNegative = false
            }
        }
    }

    public private(set) var magnitude: WholeNumber {
        get {
            return definition.magnitude
        }
        set {
            definition.magnitude = newValue
        }
    }
    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    public private(set) var isNegative: Bool {
        get {
            return definition.isNegative
        }
        set {
            definition.isNegative = newValue
        }
    }

    // MARK: - Addable

    // [_Inherit Documentation: SDGMathematics.Addable.+=_]
    /// Adds or concatenates the right value to the left, or performs a similar operation implied by the “+” symbol. Exact behaviour depends on the type.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout Integer, rhs: Integer) {

        if lhs.isNegative == rhs.isNegative {
            // Moving away from zero.
            lhs.magnitude += rhs.magnitude
        } else {
            // Approaching zero...
            if lhs.magnitude ≥ rhs.magnitude {
                // ...but stopping short of crossing it.
                lhs.magnitude −= rhs.magnitude
            } else {
                // ...and crossing it.
                lhs.magnitude = rhs.magnitude − lhs.magnitude
                lhs.isNegative¬=
            }
        }
    }

    // MARK: - Comparable

    // [_Inherit Documentition: SDGMathematics.Comparable.<_]
    public static func < (lhs: Integer, rhs: Integer) -> Bool {
        if lhs.isNegative {
            if rhs.isNegative {
                // − vs −
                return lhs.magnitude > rhs.magnitude
            } else {
                // − vs +/0
                return true
            }
        } else {
            if rhs.isNegative {
                // +/0 vs −
                return false
            } else {
                // +/0 vs +/0
                return lhs.magnitude < rhs.magnitude
            }
        }
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGLogic.Equatable.==_]
    /// 🇨🇦🇬🇧🇺🇸 Returns `true` if the two values are equal. • 🇩🇪 Gibt `wahr` zurück, wenn die zwei Werte gleich sind. • 🇫🇷 Retourne `vrai` si les deux valeurs sont égales. • 🇬🇷 Επιστρέφει `αληθής` αν οι τιμές είναι ίσες.
    ///
    /// - Parameters:
    ///     - lhs: 🇨🇦🇬🇧🇺🇸 A value to compare. • 🇩🇪 Ein Wert, der verglichen werden soll. • 🇫🇷 Une valeur á comparer. • 🇬🇷 Μία τιμή που πρέπει συγκρίνεται.
    ///     - rhs: 🇨🇦🇬🇧🇺🇸 Another value to compare. • 🇩🇪 Ein weiterer Wert, der verglichen werden soll. • 🇫🇷 Une autre valeur à comparer. • 🇬🇷 Μία αλλη τιμή που πρέπει συγκρίνεται.
    public static func == (lhs: Integer, rhs: Integer) -> Bool {
        return (lhs.isNegative, lhs.magnitude) == (rhs.isNegative, rhs.magnitude)
    }

    // MARK: - ExpressibleByIntegerLiteral

    public typealias IntegerLiteralType = IntMax

    public init(integerLiteral: IntegerLiteralType) {
        magnitude = WholeNumber(UIntMax(|integerLiteral|))
        isNegative = integerLiteral.isNegative
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

    // MARK: - PointType

    // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Integer

    // MARK: - Subtractable

    // [_Inherit Documentation: SDGMathematics.Subtractable.−=_]
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout Integer, rhs: Integer) {
        lhs += −rhs
    }

    // MARK: - WholeArithmetic

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.×=_]
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The coefficient by which to multiply.
    ///
    /// - NonmutatingVariant: ×
    ///
    /// - RecommendedOver: *=
    public static func ×= (lhs: inout Integer, rhs: Integer) {
        lhs.magnitude ×= rhs.magnitude
        if lhs.isNegative == rhs.isNegative {
            lhs.isNegative = false
        } else {
            lhs.isNegative = true
        }
    }

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.divideAccordingToEuclid(by:)_]
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - NonmutatingVariant: dividedAccordingToEuclid
    public mutating func divideAccordingToEuclid(by divisor: Integer) {

        let negative = (self.isNegative ∧ divisor.isPositive) ∨ (self.isPositive ∧ divisor.isNegative)

        let needsToWrapToPrevious = negative ∧ ¬magnitude.isDivisible(by: divisor.magnitude)
        // Wrap to previous if negative (ignoring when exactly even)

        magnitude.divideAccordingToEuclid(by: divisor.magnitude)
        isNegative = negative

        if needsToWrapToPrevious {
            self −= 1
        }
    }

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Integer>, fromRandomizer randomizer: Randomizer) {

        if range.lowerBound.isWhole {
            let wholeRange: ClosedRange<WholeNumber> = range.lowerBound.magnitude ... range.upperBound.magnitude
            let whole = WholeNumber(randomInRange: wholeRange, fromRandomizer: randomizer)
            self = Integer(whole)
        } else {
            let span = range.upperBound − range.lowerBound
            let wholeRange: ClosedRange<WholeNumber> = 0 ... span.magnitude
            let whole = WholeNumber(randomInRange: wholeRange, fromRandomizer: randomizer)
            self = range.lowerBound + Integer(whole)
        }
    }
}
