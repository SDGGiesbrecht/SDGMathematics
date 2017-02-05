/*
 Measurement.swift

 This source file is part of the SDGMathematics open source project.
 https://github.com/SDGGiesbrecht/SDGMathematics

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that represents a measurement that can be expressed in various units.
///
/// See `Angle` for an example.
///
/// - Requires: A `Measurement`’s units must be definable as ratios of one another. (For example, `Measurement` can describe angles as radians, degrees and gradians, but not temperature as Kelvins, Celsius and Fahrenheit.)
///
/// Conformance Requirements:
///
/// - `init(rawValue: Scalar)`
/// - `var rawValue: Scalar { get set }`
public protocol Measurement: Addable, Comparable, Equatable, Negatable, NumericAdditiveArithmetic {
    
    // MARK: - Scalar Type
    
    /// The numeric type used to express the value in any given unit.
    associatedtype Scalar: RationalArithmetic
    
    // MARK: - Internal Values
    
    /// Creates a measurement from a raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    init(rawValue: Scalar)
    
    /// A raw value in undefined but consistent units.
    ///
    /// Used by `Measurement`’s default implementation of methods where various units make no difference (such as multiplication by a scalar).
    var rawValue: Scalar { get set }
    
    // MARK: - Initialization
    
    /// Creates an empty (zero) measurement.
    init()
    
    // MARK: - Operations
    
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement.
    ///     - rhs: The scalar.
    ///
    /// - SeeAlso: `×=(_:_:)` (mutating variant)
    static func ×(lhs: Self, rhs: Scalar) -> Self
    
    /// Modifies the measurement by multiplication with a scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement to modify.
    ///     - rhs: The scalar.
    ///
    /// - SeeAlso: `×(_:_:)` (non‐mutating variant)
    static func ×=(lhs: inout Self, rhs: Scalar)
    
    /// Returns the (rational) quotient of a measurement divided by a scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement.
    ///     - rhs: The scalar.
    ///
    /// - SeeAlso: `÷=(_:_:)` (mutating variant)
    static func ÷(lhs: Self, rhs: Scalar) -> Self
    
    /// Returns the (rational) scalar quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    static func ÷(lhs: Self, rhs: Self) -> Scalar
    
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The measurement to modify.
    ///     - rhs: The scalar divisor.
    ///
    /// - SeeAlso: `÷(_:_:)` (non‐mutating variant)
    static func ÷=(lhs: inout Self, rhs: Scalar)
    
    // A MEAUSUREMENT IS NOT AN INTEGER WITHOUT AN ARBITRARY SELECTION OF A UNIT, SO *EUCLIDEAN* DIVISON BY A SCALAR IS MEANINGLESS
    
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - SeeAlso: `divideAccordingToEuclid(by:)` (mutating variant)
    func dividedAccordingToEuclid(by divisor: Self) -> Scalar
    
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
    
    // MARK: - Rounding
    
    /// A rule for rounding.
    typealias RoundingRule = FloatingPointRoundingRule
    
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
    
    // MARK: - Randomization
    
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: Range<Self>)
    
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: ClosedRange<Self>)
    
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer)
    
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer)
}

// MARK: - Measurements

/// Returns the greatest common divisor of `a` and `b`.
///
/// - Parameters:
///     - lhs: A value.
///     - rhs: Another value.
///
/// - SeeAlso: `formGreatestCommonDivisor(with:)` (mutating variant)
public func gcd<M: Measurement>(_ a: M, _ b: M) -> M {
    return M.gcd(a, b)
}

/// Returns the least common multiple of `a` and `b`.
///
/// - Parameters:
///     - lhs: A value.
///     - rhs: Another value.
///
/// - SeeAlso: `formGreatestCommonDivisor(with:)` (mutating variant)
public func lcm<M: Measurement>(_ a: M, _ b: M) -> M {
    return M.lcm(a, b)
}

extension Measurement {
    
    /// Creates an empty (zero) measurement.
    public init() {
        self.init(rawValue: 0)
    }
    
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement.
    ///     - rhs: The scalar.
    ///
    /// - SeeAlso: `×=(_:_:)` (mutating variant)
    public static func ×(lhs: Self, rhs: Scalar) -> Self {
        var result = lhs
        result ×= rhs
        return result
    }
    
    /// Returns the result of multipling the measurement by the scalar.
    ///
    /// - Parameters:
    ///     - lhs: The scalar.
    ///     - rhs: The measurement.
    ///
    /// - SeeAlso: `×=(_:_:)` (mutating variant)
    public static func ×(lhs: Scalar, rhs: Self) -> Self {
        return rhs × lhs
    }
    
    /// Modifies the measurement by multiplication with a scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement to modify.
    ///     - rhs: The scalar.
    ///
    /// - SeeAlso: `×(_:_:)` (non‐mutating variant)
    public static func ×=(lhs: inout Self, rhs: Scalar) {
        lhs.rawValue ×= rhs
    }
    
    /// Returns the (rational) quotient of a measurement divided by a scalar.
    ///
    /// - Parameters:
    ///     - lhs: The measurement.
    ///     - rhs: The scalar.
    ///
    /// - SeeAlso: `÷=(_:_:)` (mutating variant)
    public static func ÷(lhs: Self, rhs: Scalar) -> Self {
        var result = lhs
        result ÷= rhs
        return result
    }
    
    /// Returns the (rational) scalar quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    public static func ÷(lhs: Self, rhs: Self) -> Scalar {
        return lhs.rawValue ÷ rhs.rawValue
    }
    
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The measurement to modify.
    ///     - rhs: The scalar divisor.
    ///
    /// - SeeAlso: `÷(_:_:)` (non‐mutating variant)
    public static func ÷=(lhs: inout Self, rhs: Scalar) {
        lhs.rawValue ÷= rhs
    }
    
    // A MEAUSUREMENT IS NOT AN INTEGER WITHOUT AN ARBITRARY SELECTION OF A UNIT, SO *EUCLIDEAN* DIVISON BY A SCALAR IS MEANINGLESS
    
    /// Returns the integral quotient of `self` divided by `divisor`.
    ///
    /// - Note: This is a true mathematical quotient. i.e. (−5) ÷ 3 = −2 remainder 1, *not* −1 remainder −2
    ///
    /// - Parameters:
    ///     - divisor: The divisor.
    ///
    /// - SeeAlso: `divideAccordingToEuclid(by:)` (mutating variant)
    public func dividedAccordingToEuclid(by divisor: Self) -> Scalar {
        return rawValue.dividedAccordingToEuclid(by: divisor.rawValue)
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
        rawValue.formRemainder(mod: divisor.rawValue)
    }
    
    /// Returns `true` if `self` is evenly divisible by `divisor`.
    public func isDivisible(by divisor: Self) -> Bool {
        return rawValue.isDivisible(by: divisor.rawValue)
    }
    
    /// Returns the greatest common divisor of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `formGreatestCommonDivisor(with:)` (mutating variant)
    public static func gcd(_ a: Self, _ b: Self) -> Self {
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
        rawValue.formGreatestCommonDivisor(with: other.rawValue)
    }
    
    /// Returns the least common multiple of `a` and `b`.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    ///
    /// - SeeAlso: `formGreatestCommonDivisor(with:)` (mutating variant)
    public static func lcm(_ a: Self, _ b: Self) -> Self {
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
        rawValue.formLeastCommonMultiple(with: other.rawValue)
    }
    
    /// Rounds the value to a multiple of `factor` using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///     - factor: The factor to round to a multiple of.
    ///
    /// - SeeAlso: `rounded(_:toMultipleOf:)` (non‐mutating variant)
    public mutating func round(_ rule: RoundingRule, toMultipleOf factor: Self) {
        rawValue.round(rule, toMultipleOf: factor.rawValue)
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
    
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: Range<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }
    
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: ClosedRange<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }
    
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer) {
        let scalar = Scalar(randomInRange: range.lowerBound.rawValue ..< range.upperBound.rawValue, fromRandomizer: randomizer)
        self.init(rawValue: scalar)
    }
    
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Self>, fromRandomizer randomizer: Randomizer) {
        let scalar = Scalar(randomInRange: range.lowerBound.rawValue ... range.upperBound.rawValue, fromRandomizer: randomizer)
        self.init(rawValue: scalar)
    }
}
