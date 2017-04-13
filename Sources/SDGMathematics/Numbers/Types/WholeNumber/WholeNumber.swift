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

    // MARK: - Initialization

    public init<U : UIntType>(_ uInt: U) {
        digits = [uInt.toUIntMax()]
    }

    // MARK: - Properties

    internal typealias Digit = UIntMax
    internal typealias DigitIndex = Int
    private var unsafeDigits: [Digit] = []
    private var digits: [Digit] {
        get {
            return unsafeDigits
        }
        set {
            unsafeDigits = newValue

            // Normalize

            while unsafeDigits.last == 0 {
                unsafeDigits.removeLast()
            }
        }
    }

    internal var digitIndices: CountableRange<DigitIndex> {
        return digits.indices
    }

    internal subscript(digitIndex: DigitIndex) -> Digit {
        get {
            guard digitIndex < digits.endIndex else {
                return 0
            }

            return digits[digitIndex]
        }
        set {
            var temporaryLeadingZeroes = digits

            let missingDigits = digitIndex + 1 − digits.endIndex
            if missingDigits > 0 {
                temporaryLeadingZeroes.append(contentsOf: [Digit](repeating: 0, count: missingDigits))
            }
            temporaryLeadingZeroes[digitIndex] = newValue

            digits = temporaryLeadingZeroes
        }
    }

    internal typealias BinaryView = WholeNumberBinaryView
    private var binaryView: BinaryView {
        get {
            return BinaryView(self)
        }
        set {
            self = newValue.wholeNumber
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

        var carrying: Digit = 0
        for digitIndex in rhs.digits.indices {

            var augend = lhs[digitIndex]
            let addend = rhs[digitIndex]

            let carried = carrying
            carrying = 0

            augend.add(addend, carringIn: &carrying)
            augend.add(carried, carringIn: &carrying)

            lhs[digitIndex] = augend
        }

        lhs[rhs.digits.endIndex] += carrying
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

    public typealias IntegerLiteralType = UIntMax

    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }

    // MARK: - PointType

    // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Integer

    // [_Inherit Documentation: SDGMathematics.PointType.+=_]
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout WholeNumber, rhs: Vector) {
        // [_Warning: No implementation yet._]
        fatalError()
    }

    // [_Inherit Documentation: SDGMathematics.PointType.−_]
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    public static func − (lhs: WholeNumber, rhs: WholeNumber) -> Vector {
        // [_Warning: No implementation yet._]
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
        assert(lhs ≥ rhs, "\(lhs) − \(rhs) is impossible for \(WholeNumber.self).")

        var borrowing: Digit = 0
        for digitIndex in rhs.digits.indices {

            var minuend = lhs[digitIndex]
            let subtrahend = rhs[digitIndex]

            let borrowed = borrowing
            borrowing = 0

            minuend.subtract(subtrahend, borrowingIn: &borrowing)
            minuend.subtract(borrowed, borrowingIn: &borrowing)

            lhs[digitIndex] = minuend
        }

        lhs[rhs.digits.endIndex] −= borrowing
    }

    // MARK: - WholeArithmetic

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.×_]
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - MutatingVariant: ×=
    ///
    /// - RecommendedOver: *
    public static func × (lhs: WholeNumber, rhs: WholeNumber) -> WholeNumber {

        var product: WholeNumber = 0

        for rhsIndex in rhs.digits.indices {
            for lhsIndex in lhs.digits.indices {

                let lhsDigit = lhs.digits[lhsIndex]
                let rhsDigit = rhs.digits[rhsIndex]

                let digitResult = Digit.multiply(lhsDigit, with: rhsDigit)

                let productIndex = lhsIndex + rhsIndex
                var addend: WholeNumber = 0
                addend[productIndex] = digitResult.product
                addend[productIndex + 1] = digitResult.carried

                product += addend
            }
        }

        return product
    }

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
        lhs = lhs × rhs
    }

    internal func quotientAndRemainder(for divisor: WholeNumber) -> (quotient: WholeNumber, remainder: WholeNumber) {

        var quotient: WholeNumber = 0
        var remainingDividend = self

        for bitPosition in binaryView.indicesBackwards() {
            let distance = binaryView.endIndex − bitPosition
            if distance ≥ divisor.binaryView.count ∧ divisor.binaryView.count ≤ remainingDividend.binaryView.count {
                var divides = true // If the following iteration finishes, it is exactly equal and divides precicely once.
                for (dividendBit, divisorBit) in zip(remainingDividend.binaryView.lastBitsBackwards(maximum: divisor.binaryView.count), divisor.binaryView.bitsBackwards()) where dividendBit ≠ divisorBit {
                    if dividendBit < divisorBit {
                        divides = false
                        break
                    }
                    if dividendBit > divisorBit {
                        divides = true
                        break
                    }
                }

                if divides {
                    quotient.binaryView[bitPosition] = true

                    var shiftedDivisor = divisor
                    shiftedDivisor.binaryView.shiftLeft(bitPosition − binaryView.startIndex)
                    remainingDividend −= shiftedDivisor
                }
            }
        }

        return (quotient, remainingDividend)
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
        self = quotientAndRemainder(for: divisor).quotient
    }

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.formRemainder(mod:)_]
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - NonmutatingVariant: mod
    public mutating func formRemainder(mod divisor: WholeNumber) {
        self = quotientAndRemainder(for: divisor).remainder
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
