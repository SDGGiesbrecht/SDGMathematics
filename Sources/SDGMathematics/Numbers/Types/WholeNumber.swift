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

fileprivate typealias Digit = UIntMax

/// An arbitrary‐precision whole number.
///
/// `WholeNumber` has a current theoretical limit of about 10 ↑ 178 000 000 000 000 000 000, but since that would occupy over 73 exabytes, in practice `WholeNumber` is limited by the amount of memory available.
public struct WholeNumber : Addable, Comparable, Equatable, ExpressibleByIntegerLiteral, PointType, Strideable, Subtractable, WholeArithmetic, WholeNumberType {

    // MARK: - Initialization

    public init<U : UIntType>(_ uInt: U) {
        digits = [uInt.toUIntMax()]
        normalize()
    }

    // MARK: - Properties

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

    public typealias IntegerLiteralType = UIntMax

    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }

    // MARK: - PointType

    // [_Warning: Awaiting implementation of Integer : IntegralArithmetic._]
    // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Int

    // [_Inherit Documentation: SDGMathematics.PointType.+=_]
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - NonmutatingVariant: +
    public static func += (lhs: inout WholeNumber, rhs: Vector) {
        // [_Warning: Awaiting implementation of Integer : IntegralArithmetic._]
        fatalError()
    }

    // [_Inherit Documentation: SDGMathematics.PointType.−_]
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
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

        lhs.normalize()
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

fileprivate extension Digit {

    // MARK: - Addition

    fileprivate mutating func add(_ addend: Digit, carringIn carrying: inout Digit) {
        let (simpleSum, overflowed) = Digit.addWithOverflow(self, addend)
        self = simpleSum
        if overflowed {
            carrying += 1
        }
    }

    // MARK: - Subtraction

    fileprivate mutating func subtract(_ subtrahend: Digit, borrowingIn borrowing: inout Digit) {
        let (simpleDifference, overflowed) = Digit.subtractWithOverflow(self, subtrahend)
        self = simpleDifference
        if overflowed {
            borrowing += 1
        }
    }

    // MARK: - Multiplication

    private typealias GeneralNumber = Digit
    private typealias Subdigit = Digit
    private typealias Subdigits = Digit
    private typealias /*Subdigits.*/Index = Digit

    //   ____      _b_
    //  ╱ b        2
    // √  2    =  2
    private static let subdigitsPerDigit: GeneralNumber = 2
    private static let /*Subdigits.*/endIndex: Subdigits.Index = subdigitsPerDigit

    private static let /*Subdigits.*/size: Subdigits.Index = {
        let totalSize = GeneralNumber(MemoryLayout<Digit>.size)
        assert(totalSize.isDivisible(by: subdigitsPerDigit), "\(Digit.self) has an incompatible memory layout.")
        return totalSize.dividedAccordingToEuclid(by: subdigitsPerDigit)
    }()
    private static let /*Subdigit.*/mask: Subdigit = (1 << Subdigit.size) − 1

    private subscript(index: Subdigits.Index) -> Subdigit {
        get {
            assert(index < Subdigits.Index.endIndex)
            let offset = index × Subdigit.size
            return (self & (Subdigit.mask << offset)) >> offset
        }
        set {
            assert(index < Subdigits.Index.endIndex)
            let offset = index × Subdigit.size
            let oldErased = self & ~(Subdigit.mask << offset)
            self = oldErased | (newValue << offset)
        }
    }

    private init(subdigit: Subdigit, at index: Subdigits.Index) {
        self = 0
        self[index] = subdigit
    }

    fileprivate static func multiply(_ multiplicand: Digit, with multiplier: Digit) -> (product: Digit, carried: Digit) {

        func multiplySubdigit(_ multiplicand: Subdigit, with multiplier: Subdigit) -> (product: Subdigit, carried: Subdigit) {

            let product = multiplicand × multiplier
            return (product: product[0], carried: product[1])
        }

        var product: Digit = 0
        var carried: Digit = 0
        func add(subdigit: Subdigit, at index: Subdigits.Index) {
            if index < subdigitsPerDigit {
                product.add(Digit(subdigit: subdigit, at: index), carringIn: &carried)
            } else {
                carried += Digit(subdigit: subdigit, at: index − subdigitsPerDigit)
            }
        }
        for multiplierIndex in 0 ..< subdigitsPerDigit {
            for multiplicandIndex in 0 ..< subdigitsPerDigit {

                let digitResult = multiplySubdigit(multiplicand[multiplicandIndex], with: multiplier[multiplierIndex])

                let productIndex = multiplicandIndex + multiplierIndex
                add(subdigit: digitResult.product, at: productIndex)

                if digitResult.carried ≠ 0 {
                    add(subdigit: digitResult.carried, at: productIndex + 1)
                }
            }
        }

        return (product: product, carried: carried)
    }
}
