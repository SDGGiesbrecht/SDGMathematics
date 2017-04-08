/*
 WholeNumber.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// An arbitrary‐precision whole number.
///
/// `WholeNumber` has a current theoretical limit of about 10 ↑ 178 000 000 000 000 000 000, but since that would occupy over 73 exabytes, in practice `WholeNumber` is limited by the amount of memory available.
public struct WholeNumber : Addable, Comparable, Equatable, ExpressibleByIntegerLiteral, PointType, Strideable, Subtractable, WholeArithmetic, WholeNumberType {

    // MARK: - Properties

    private typealias Digit = UInt64
    private typealias DigitIndex = Int
    private var digits: [Digit] = []

    private subscript(digitIndex: DigitIndex) -> Digit {
        get {
            guard digitIndex < digits.endIndex else {
                return 0
            }

            return digits[digitIndex]
        }
        set {
            let missingDigits = digitIndex + 1 − digits.endIndex
            if missingDigits > 0 {
                digits.append(contentsOf: [Digit](repeating: 0, count: missingDigits))
            }
            digits[digitIndex] = newValue
        }
    }

    // MARK: - Normalization

    private mutating func normalize() {
        while digits.last == 0 {
            digits.removeLast()
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
    public static func += (lhs: inout WholeNumber, rhs: WholeNumber) {

        func add(_ addend: Digit, to augend: inout Digit, carryingIn carrying: inout Digit) {

            let (simpleSum, overflowed) = Digit.addWithOverflow(augend, addend)
            if ¬overflowed {
                augend = simpleSum
            } else {
                let used = Digit.max − augend + 1
                augend = addend − used
                carrying += 1
            }
        }

        var overflow: Digit = 0
        for digitIndex in rhs.digits.indices {

            var augend = lhs[digitIndex]
            let addend = rhs[digitIndex]

            let carried = overflow
            overflow = 0

            add(addend, to: &augend, carryingIn: &overflow)
            add(carried, to: &augend, carryingIn: &overflow)

            lhs[digitIndex] = augend
        }

        add(overflow, to: &lhs[rhs.digits.endIndex], carryingIn: /* unused */ &overflow)

        lhs.normalize()
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGMathematics.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func < (lhs: WholeNumber, rhs: WholeNumber) -> Bool {

        if lhs.digits.count ≠ rhs.digits.count {
            return lhs.digits.count < rhs.digits.count
        }

        for digitIndex in lhs.digits.indices.lazy.reversed() {
            let left = lhs.digits[digitIndex]
            let right = rhs.digits[digitIndex]

            if left ≠ right {
                return left < right
            }
        }

        return false // Equal
    }

    // MARK: - Equatable

    // [_Inherit Documentation: SDGLogic.Equatable.==_]
    /// 🇨🇦🇬🇧🇺🇸 Returns `true` if the two values are equal. • 🇩🇪 Gibt `wahr` zurück, wenn die zwei Werte gleich sind. • 🇫🇷 Retourne `vrai` si les deux valeurs sont égales. • 🇬🇷 Επιστρέφει `αληθής` αν οι τιμές είναι ίσες.
    ///
    /// - Parameters:
    ///     - lhs: 🇨🇦🇬🇧🇺🇸 A value to compare. • 🇩🇪 Ein Wert, der verglichen werden soll. • 🇫🇷 Une valeur á comparer. • 🇬🇷 Μία τιμή που πρέπει συγκρίνεται.
    ///     - rhs: 🇨🇦🇬🇧🇺🇸 Another value to compare. • 🇩🇪 Ein weiterer Wert, der verglichen werden soll. • 🇫🇷 Une autre valeur à comparer. • 🇬🇷 Μία αλλη τιμή που πρέπει συγκρίνεται.
    public static func == (lhs: WholeNumber, rhs: WholeNumber) -> Bool {
        return lhs.digits.elementsEqual(rhs.digits)
    }

    // MARK: - ExpressibleByIntegerLiteral

    public typealias IntegerLiteralType = UInt64

    public init(integerLiteral value: IntegerLiteralType) {
        digits = [value]
        normalize()
    }

    // MARK: - PointType

    // [_Warning: Awaiting implementation of Integer._]
    public typealias Vector = Int

    public static func − (lhs: WholeNumber, rhs: WholeNumber) -> Vector {
        // [_Warning: Awaiting implementation of Integer._]
        fatalError()
    }

    // MARK: - Strideable

    public typealias Stride = Vector

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
    public static func −= (lhs: inout WholeNumber, rhs: WholeNumber) {

        func subtract(_ subtrahend: Digit, from minuend: inout Digit, borrowingIn borrowing: inout Digit) {
            let (simpleDifference, overflowed) = Digit.subtractWithOverflow(minuend, subtrahend)
            if ¬overflowed {
                minuend = simpleDifference
            } else {
                let used = subtrahend − minuend
                minuend = Digit.max − (subtrahend − used) + 1
                borrowing += 1
            }
        }

        var underflow: Digit = 0
        for digitIndex in rhs.digits.indices {

            var minuend = lhs[digitIndex]
            let subtrahend = rhs[digitIndex]

            let borrowed = underflow
            underflow = 0

            subtract(subtrahend, from: &minuend, borrowingIn: &underflow)
            subtract(borrowed, from: &minuend, borrowingIn: &underflow)

            lhs[digitIndex] = minuend
        }

        subtract(underflow, from: &lhs[rhs.digits.endIndex], borrowingIn: /* unused */ &underflow)

        lhs.normalize()
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
    public static func ×= (lhs: inout WholeNumber, rhs: WholeNumber) {
        // [_Warning: No implementation yet._]
        fatalError()
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
    public mutating func divideAccordingToEuclid(by divisor: WholeNumber) {
        // [_Warning: No implementation yet.._]
        fatalError()
    }

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<WholeNumber>, fromRandomizer randomizer: Randomizer) {
        // [_Warning: No implementation yet.._]
        fatalError()
    }
}
