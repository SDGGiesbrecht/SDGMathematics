// WholeArithmetic.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

import SDGLogic

/// Performs multiplication.
///
/// - SeeAlso: `×=(_:_:)` (mutating variant)
///
/// - SeeAlso: (recommended over) `*(_:_:)`
infix operator ×: MultiplicationPrecedence

// swiftlint:disable multiply_and_set
/// Modifies the left by multiplication with the right.
///
/// - SeeAlso: ×`(_:_:)` (non‐mutating variant)
///
/// - SeeAlso: (recommended over) `*=(_:_:)`
infix operator ×=: AssignmentPrecedence
// swiftlint:enable multiply_and_set

/// A precedence group for exponent operators. (e.g. ↑)
///
/// Precedence: before `MultiplicationPrecedence`
///
/// Associativity: right
precedencegroup ExponentPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

/// Performs exponentiation.
///
/// - SeeAlso: `↑=(_:_:)` (mutating variant)
infix operator ↑: ExponentPrecedence

/// Modifies the left by exponentiation with the right.
///
/// - SeeAlso: `↑(_:_:)` (non‐mutating variant)
infix operator ↑=: AssignmentPrecedence

/// A type that can be used for whole‐number arithmetic.
///
/// Conformance Requirements:
///
/// - `NumericAdditiveArithmetic`
/// - `ExpressibleByIntegerLiteral`
/// - `static func ×=(lhs: inout Self, rhs: Self)`
/// - `mutating func divideAccordingToEuclid(by divisor: Self)`
/// - `WholeNumberType`, `IntegerType`, `RationalNumberType` or `static func ↑=(lhs: inout Self, rhs: Self)`
/// - `init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)`
public protocol WholeArithmetic: ExpressibleByIntegerLiteral, NumericAdditiveArithmetic, OneDimensionalPoint, Strideable {
    
    // MARK: - Operations
    
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `×=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `*(_:_:)`
    static func ×(lhs: Self, rhs: Self) -> Self
    
    // swiftlint:disable multiply_and_set
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The coefficient by which to multiply.
    ///
    /// - SeeAlso: `×(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `*=(_:_:)`
    static func ×=(lhs: inout Self, rhs: Self)
    // swiftlint:enable multiply_and_set
    
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - SeeAlso: `dividedAccordingToEuclid(by:)` (non‐mutating variant)
    mutating func divideAccordingToEuclid(by divisor: Self)
    
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - SeeAlso: `divideAccordingToEuclid(by:)` (mutating variant)
    func dividedAccordingToEuclid(by divisor: Self) -> Self
    
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - SeeAlso: `formRemainder(mod:)` (mutating variant)
    func mod(_ divisor: Self) -> Self
    
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - SeeAlso: `mod(_:)` (non‐mutating variant)
    mutating func formRemainder(mod divisor: Self)
    
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    func isDivisible(by divisor: Self) -> Bool
    
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `formGreatestCommonDivisor(with:)` (mutating variant)
    static func gcd(_ a: Self, _ b: Self) -> Self
    
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - SeeAlso: `gcd(_:_:)` (non‐mutating variant)
    mutating func formGreatestCommonDivisor(with other: Self)
    
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `formGreatestCommonDivisor(with:)` (mutating variant)
    static func lcm(_ a: Self, _ b: Self) -> Self
    
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - SeeAlso: `lcm(_:_:)` (non‐mutating variant)
    mutating func formLeastCommonMultiple(with other: Self)
    
    /// Returns the result of the left to the power of the right.
    ///
    /// - Precondition: (a) If `Self` conforms to `IntegerType`, `rhs` must be non‐negative. (b) If `Self` conforms to `RationalNumberType`, `rhs` must be an integer. (c) If `Self` conforms to `RealNumberType`, `lhs` must be positive or else `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The base.
    ///     - rhs: The exponent.
    ///
    /// - SeeAlso: `↑=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `pow(_:_:)`
    static func ↑(lhs: Self, rhs: Self) -> Self
    
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition: (a) If `Self` conforms to `IntegerType`, `rhs` must be non‐negative. (b) If `Self` conforms to `RationalNumberType`, `rhs` must be an integer. (c) If `Self` conforms to `RealNumberType`, `lhs` must be positive or else `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - SeeAlso: `↑(_:_:)` (non‐mutating variant)
    static func ↑=(lhs: inout Self, rhs: Self)
    
    // MARK: - Classification
    
    /// Returns `true` if `self` is a natural number.
    var isANaturalNumber: Bool { get }
    
    /// Returns `true` if `self` is a whole number.
    var isAWholeNumber: Bool { get }
    
    /// Returns `true` if `self` is an integer.
    var isAnInteger: Bool { get }
    
    /// Returns true if `self` is an even integer.
    var isEven: Bool { get }
    
    /// Returns true if `self` is an odd integer.
    var isOdd: Bool { get }
    
    // MARK: - Rounding
    
    /// A rule for rounding.
    typealias RoundingRule = FloatingPointRoundingRule
    
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - SeeAlso: `rounded(_:)` (non‐mutating variant)
    mutating func round(_ rule: RoundingRule)
    
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - SeeAlso: `round(_:)` (mutating variant)
    func rounded(_ rule: RoundingRule) -> Self
    
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - SeeAlso: `rounded(_:toMultipleOf:)` (non‐mutating variant)
    mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self)
    
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - SeeAlso: `round(_:toMultipleOf:)` (mutating variant)
    func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self
    
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: ClosedRange<Self>)
    
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)
}

// MARK: - Whole Arithmetic

/// Returns the greatest common divisor of `a` and `b`.
///
/// - Parameters:
///     - lhs: A value.
///     - rhs: Another value.
///
/// - SeeAlso: `formGreatestCommonDivisor(with:)` (mutating variant)
public func gcd<N: WholeArithmetic>(_ a: N, _ b: N) -> N {
    return N.gcd(a, b)
}

/// Returns the least common multiple of `a` and `b`.
///
/// - Parameters:
///     - lhs: A value.
///     - rhs: Another value.
///
/// - SeeAlso: `formGreatestCommonDivisor(with:)` (mutating variant)
public func lcm<N: WholeArithmetic>(_ a: N, _ b: N) -> N {
    return N.lcm(a, b)
}

extension WholeArithmetic {
    
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `×=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `*(_:_:)`
    public static func ×(lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ×= rhs
        return result
    }
    
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - SeeAlso: `divideAccordingToEuclid(by:)` (mutating variant)
    public func dividedAccordingToEuclid(by divisor: Self) -> Self {
        var result = self
        result.divideAccordingToEuclid(by: divisor)
        return result
    }
    
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - SeeAlso: `formRemainder(mod:)` (mutating variant)
    public func mod(_ divisor: Self) -> Self {
        var result = self
        result.formRemainder(mod: divisor)
        return result
    }
    
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - SeeAlso: `mod(_:)` (non‐mutating variant)
    public mutating func formRemainder(mod divisor: Self) {
        self −= dividedAccordingToEuclid(by: divisor) × divisor
    }
    
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    public func isDivisible(by divisor: Self) -> Bool {
        return mod(divisor) == 0
    }
    
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `formGreatestCommonDivisor(with:)` (mutating variant)
    public static func gcd<N: WholeArithmetic>(_ a: N, _ b: N) -> N {
        var result = a
        result.formGreatestCommonDivisor(with: b)
        return result
    }
    
    /// Sets `self` to the greatest common divisor of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - SeeAlso: `gcd(_:_:)` (non‐mutating variant)
    public mutating func formGreatestCommonDivisor(with other: Self) {
        if self.isNegative ∨ other.isNegative {
            self.formAbsoluteValue()
            formGreatestCommonDivisor(with: |other|)
        } else if other == 0 /* finished */ {
            // self = self
        } else {
            self = gcd(other, mod(other))
        }
    }
    
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `formGreatestCommonDivisor(with:)` (mutating variant)
    public static func lcm<N: WholeArithmetic>(_ a: N, _ b: N) -> N {
        var result = a
        result.formLeastCommonMultiple(with: b)
        return result
    }
    
    /// Sets `self` to the least common multiple of `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: Another value.
    ///
    /// - SeeAlso: `lcm(_:_:)` (non‐mutating variant)
    public mutating func formLeastCommonMultiple(with other: Self) {
        self ×= other.dividedAccordingToEuclid(by: gcd(self, other))
    }
    
    /// Returns the result of the left to the power of the right.
    ///
    /// - Parameters:
    ///     - lhs: The base.
    ///     - rhs: The exponent.
    ///
    /// - SeeAlso: `↑=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `pow(_:_:)`
    public static func ↑(lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ↑= rhs
        return result
    }
    
    fileprivate mutating func raiseWholeNumberToThePowerOf(wholeNumber exponent: Self) {
        if exponent == 0 {
            self = 1
        } else if exponent == 1 {
            // self = self
        } else if exponent.isEven {
            // p = (b ↑ 2) ↑ (e ÷ 2)
            self ×= self
            self ↑= (exponent.dividedAccordingToEuclid(by: 2))
        } else /* rhs.isOdd */ {
            // p = b × b ↑ (e − 1)
            self ×= (self ↑ (exponent − 1))
        }
    }
    
    /// Returns `true` if `self` is a natural number.
    public var isANaturalNumber: Bool {
        return isAWholeNumber ∧ self ≠ 0
    }
    
    /// Returns `true` if `self` is a whole number.
    public var isAWholeNumber: Bool {
        return isAnInteger ∧ isNonNegative
    }
    
    /// Returns `true` if `self` is an integer.
    public var isAnInteger: Bool {
        return isDivisible(by: 1)
    }
    
    /// Returns true if `self` is an even integer.
    public var isEven: Bool {
        return isDivisible(by: 2)
    }
    
    /// Returns true if `self` is an odd integer.
    public var isOdd: Bool {
        return isAnInteger ∧ ¬isEven
    }
    
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - SeeAlso: `rounded(_:toMultipleOf:)` (non‐mutating variant)
    public mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self) {
        switch rule {
        case .down:
            self.divideAccordingToEuclid(by: factor)
            self ×= factor
        case .up:
            if ¬isDivisible(by: factor) {
                round(.down, toMultipleOf: factor)
                self += factor
            }
        case .towardZero:
            if isNegative {
                round(.up, toMultipleOf: factor)
            } else {
                round(.down, toMultipleOf: factor)
            }
        case .awayFromZero:
            if isNegative {
                round(.down, toMultipleOf: factor)
            } else {
                round(.up, toMultipleOf: factor)
            }
        default:
            let floor = rounded(.down, toMultipleOf: factor)
            let portion: Self = self − floor
            let double = portion × 2
            
            if double < factor /* portion < half */ {
                self = floor
            } else if double > factor /* portion > half */ {
                self = floor + factor
            } else {
                // portion == half
                switch rule {
                case .toNearestOrAwayFromZero:
                    if isNegative {
                        self = floor
                    } else {
                        self = floor + factor
                    }
                case .toNearestOrEven:
                    if floor.dividedAccordingToEuclid(by: factor).isEven {
                        self = floor
                    } else {
                        self = floor + factor
                    }
                default:
                    assertionFailure("This line of code should be unreachable. All RoundingRule cases should already accounted for.")
                }
            }
        }
    }
    
    /// Returns the value rounded to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - SeeAlso: `round(_:toMultipleOf:)` (mutating variant)
    public func rounded(_ rule: RoundingRule, toMultipleOf factor: Self) -> Self {
        var result = self
        result.round(rule, toMultipleOf: factor)
        return result
    }
    
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - SeeAlso: `rounded(_:)` (non‐mutating variant)
    public mutating func round(_ rule: RoundingRule) {
        round(rule, toMultipleOf: 1)
    }
    
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - SeeAlso: `round(_:)` (mutating variant)
    public func rounded(_ rule: RoundingRule) -> Self {
        var result = self
        result.round(rule)
        return result
    }
    
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: ClosedRange<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }
}

extension WholeArithmetic where Self : FloatType {
    // MARK: - where Self : FloatType
    
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `×=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `*(_:_:)`
    public static func ×(lhs: Self, rhs: Self) -> Self {
        // swiftlint:disable multiplication
        return lhs * rhs
        // swiftlint:enable multiplication
    }
    
    // swiftlint:disable multiply_and_set
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The coefficient by which to multiply.
    ///
    /// - SeeAlso: `×(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `*=(_:_:)`
    public static func ×=(lhs: inout Self, rhs: Self) {
        lhs *= rhs
    }
    // swiftlint:enable multiply_and_set
    
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - SeeAlso: `dividedAccordingToEuclid(by:)` (non‐mutating variant)
    public mutating func divideAccordingToEuclid(by divisor: Self) {
        self ÷= divisor
        self.round(.down)
    }
    
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition: `lhs` must be positive or else `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - SeeAlso: `↑(_:_:)` (non‐mutating variant)
    public static func ↑=(lhs: inout Self, rhs: Self) {
        
        assert(lhs.isNonNegative ∨ rhs.isAnInteger, "The result of a negative number raised to a non‐integer exponent may be outside the set of real numbers. Use a type that can represent complex numbers instead.")
        
        if rhs.isAnInteger {
            lhs.raiseRationalNumberToThePowerOf(rationalNumber: rhs)
        } else if rhs.isNegative /* but not an integer */ {
            lhs = 1 ÷ lhs ↑ −rhs
        } else if lhs == e /* (natural) exponential function */ {
            
            // if x = e ↑ (w + r)
            // then x = e ↑ w × e ↑ r
            let w: Self = rhs.rounded(.toNearestOrAwayFromZero)
            let r: Self = rhs − w
            
            lhs.raiseRationalNumberToThePowerOf(rationalNumber: w)
            
            // The Taylor series around 0 will converge for any real r:
            //
            //   ∞       n
            //   ∑   ( _x__ )
            // n = 0    n!
            
            var e_r: Self = 1
            var lastApproximate: Self = 0
            var n: Self = 1
            var numerator: Self = r
            var denominator: Self = n
            repeat {
                lastApproximate = e_r
                
                e_r += numerator ÷ denominator
                
                n += 1
                numerator ×= r
                denominator ×= n
                
            } while e_r ≠ lastApproximate
            
            lhs ×= e_r
            
        } else {
            lhs = e ↑ (rhs × ln(lhs))
        }
    }
    
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {
        
        // 0 ..< UInt64.max
        let random: UInt64 = randomizer.randomNumber()
        
        // 0 ..< 1
        let converted = Self(random) ÷ Self(UInt64.max)
        
        // lowerBound ..< upperBound
        self = range.lowerBound + ((range.upperBound − range.lowerBound) × converted)
    }
}

extension WholeArithmetic where Self : IntegerType {
    // MARK: - where Self : IntegerType
    
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition: `rhs` must be non‐negative.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - SeeAlso: `↑(_:_:)` (non‐mutating variant)
    public static func ↑=(lhs: inout Self, rhs: Self) {
        lhs.raiseIntegerToThePowerOf(integer: rhs)
    }
    
    /// Returns `true` if `self` is an integer.
    public var isAnInteger: Bool {
        return true
    }
    
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - SeeAlso: `rounded(_:)` (non‐mutating variant)
    public mutating func round(_ rule: RoundingRule) {
        // self = self
    }
}

extension WholeArithmetic where Self : IntegralArithmetic {
    // MARK: - where Self : IntegralArithmetic
    
    fileprivate mutating func raiseIntegerToThePowerOf(integer exponent: Self) {
        
        assert(exponent.isNonNegative, "The result of a negative exponent may be outside the set of integers. Use a type that conforms to RationalArithmeticType instead.")
        
        raiseWholeNumberToThePowerOf(wholeNumber: exponent)
    }
}

extension WholeArithmetic where Self : IntType {
    // MARK: - where Self : IntType
    
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `×=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `*(_:_:)`
    public static func ×(lhs: Self, rhs: Self) -> Self {
        // swiftlint:disable multiplication
        return lhs * rhs
        // swiftlint:enable multiplication
    }
    
    // swiftlint:disable multiply_and_set
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The coefficient by which to multiply.
    ///
    /// - SeeAlso: `×(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `*=(_:_:)`
    public static func ×=(lhs: inout Self, rhs: Self) {
        lhs *= rhs
    }
    // swiftlint:enable multiply_and_set
    
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - SeeAlso: `dividedAccordingToEuclid(by:)` (non‐mutating variant)
    public mutating func divideAccordingToEuclid(by divisor: Self) {
        
        let negative = (self.isNegative ∧ divisor.isPositive) ∨ (self.isPositive ∧ divisor.isNegative)
        
        let needsToWrapToPrevious = negative ∧ self % divisor ≠ 0
        // Wrap to previous if negative (ignoring when exactly even)
        
        // swiftlint:disable divide_and_set
        self /= divisor
        // swiftlint:enable divide_and_set
        
        if needsToWrapToPrevious {
            self −= 1
        }
    }
    
    /// Returns true if `self` is an even integer.
    public var isEven: Bool {
        return ¬isOdd
    }
    
    /// Returns true if `self` is an odd integer.
    public var isOdd: Bool {
        return self & 1 == 1
    }
    
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {
        let value = Int64(randomInRange: range.lowerBound.toIntMax() ... range.upperBound.toIntMax(), fromRandomizer: randomizer)
        self.init(value)
    }
}

extension WholeArithmetic where Self : RationalArithmetic {
    // MARK: - where Self : RationalArithmetic
    
    internal mutating func raiseRationalNumberToThePowerOf(rationalNumber exponent: Self) {
        
        assert(exponent.isAnInteger, "The result of a non‐integer exponent may be outside the set of rational numbers. Use a type that conforms to RealArithmeticType instead.")
        
        if exponent.isNegative {
            self = 1 ÷ self ↑ −exponent
        } else /* exponent.isNonNegative */ {
            raiseIntegerToThePowerOf(integer: exponent)
        }
    }
}

extension WholeArithmetic where Self : RationalNumberType {
    // MARK: - where Self : RationalNumberType
    
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Precondition: `rhs` must be an integer.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - SeeAlso: `↑(_:_:)` (non‐mutating variant)
    public static func ↑=(lhs: inout Self, rhs: Self) {
        lhs.raiseRationalNumberToThePowerOf(rationalNumber: rhs)
    }
}

extension WholeArithmetic where Self : UIntType {
    // MARK: - where Self : UIntType
    
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `×=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `*(_:_:)`
    public static func ×(lhs: Self, rhs: Self) -> Self {
        // swiftlint:disable multiplication
        return lhs * rhs
        // swiftlint:enable multiplication
    }
    
    // swiftlint:disable multiply_and_set
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The coefficient by which to multiply.
    ///
    /// - SeeAlso: `×(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `*=(_:_:)`
    public static func ×=(lhs: inout Self, rhs: Self) {
        lhs *= rhs
    }
    // swiftlint:enable multiply_and_set
    
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - SeeAlso: `divideAccordingToEuclid(by:)` (mutating variant)
    public func dividedAccordingToEuclid(by divisor: Self) -> Self {
        // swiftlint:disable division
        return self / divisor
        // swiftlint:enable division
    }
    
    /// Sets `self` to the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - SeeAlso: `dividedAccordingToEuclid(by:)` (non‐mutating variant)
    public mutating func divideAccordingToEuclid(by divisor: Self) {
        // swiftlint:disable divide_and_set
        self /= divisor
        // swiftlint:enable divide_and_set
    }
    
    /// Returns the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - SeeAlso: `formRemainder(mod:)` (mutating variant)
    public func mod(_ divisor: Self) -> Self {
        return self % divisor
    }
    
    /// Sets `self` to the Euclidean remainder of `self` ÷ `divisor`.
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - Note: This is a true mathematical modulo operation. i.e. (−5) mod 3 = 1, *not* −2
    ///
    /// - SeeAlso: `mod(_:)` (non‐mutating variant)
    public mutating func formRemainder(mod divisor: Self) {
        self %= divisor
    }
    
    /// Returns true if `self` is an even integer.
    public var isEven: Bool {
        return ¬isOdd
    }
    
    /// Returns true if `self` is an odd integer.
    public var isOdd: Bool {
        return self & 1 == 1
    }
    
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {
        let value = UInt64(randomInRange: range.lowerBound.toUIntMax() ... range.upperBound.toUIntMax(), fromRandomizer: randomizer)
        self.init(value)
    }
}

extension WholeArithmetic where Self : WholeNumberType {
    // MARK: - where Self : WholeNumberType
    
    /// Modifies the left by exponentiation with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The exponent.
    ///
    /// - SeeAlso: `↑(_:_:)` (non‐mutating variant)
    public static func ↑=(lhs: inout Self, rhs: Self) {
        lhs.raiseWholeNumberToThePowerOf(wholeNumber: rhs)
    }
    
    /// Returns `true` if `self` is a whole number.
    public var isAWholeNumber: Bool {
        return true
    }
    
    /// Returns `true` if `self` is an integer.
    public var isAnInteger: Bool {
        return true
    }
    
    /// Rounds the value to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - SeeAlso: `rounded(_:)` (non‐mutating variant)
    public mutating func round(_ rule: RoundingRule) {
        // self = self
    }
}
