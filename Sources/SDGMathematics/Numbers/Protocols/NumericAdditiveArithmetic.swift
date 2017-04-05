/*
 NumericAdditiveArithmetic.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// Computes the absolute value (in conjuction with postfix `|(_:)`).
///
///     let x = −1
///     let y = |x|
///     // y == 1
///
/// - Warning: The result of unpaired use is undefined.
prefix operator |
/// Computes the absolute value (in conjuction with prefix `|(_:)`).
///
///     let x = −1
///     let y = |x|
///     // y == 1
///
/// - Warning: The result of unpaired use is undefined.
postfix operator |

/// An one‐dimensional value that can be added and subtracted.
///
/// - Note: Unlike `WholeArithmetic`, `NumericAdditiveArithmetic` does not need a defined scale, allowing conformance by measurements that can use multiple units.
///
/// Conformance Requirements:
///
/// - `AdditiveArithmetic`
/// - `Comparable`
/// - `Negatable`, `WholeNumberType` or `mutating func formAbsoluteValue()`
public protocol NumericAdditiveArithmetic : AdditiveArithmetic, Comparable {

    // MARK: - Classification

    #if os(Linux)
    #else
    // [_Workaround: Default implementations for variables cause segmentation faults on Linux. (Swift 3.0)_]

    // [_Define Documentation: SDGMathematics.NumericAdditiveArithmetic.isPositive_]
    /// Returns `true` if `self` is positive.
    var isPositive: Bool { get }

    // [_Define Documentation: SDGMathematics.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    var isNegative: Bool { get }

    // [_Define Documentation: SDGMathematics.NumericAdditiveArithmetic.isNonNegative_]
    /// Returns `true` if `self` is positive or zero.
    var isNonNegative: Bool { get }

    // [_Define Documentation: SDGMathematics.NumericAdditiveArithmetic.isNonPositive_]
    /// Returns `true` if `self` is negative or zero.
    var isNonPositive: Bool { get }

    // MARK: - Operations

    // [_Define Documentation: SDGMathematics.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    ///
    /// - MutatingVariant: formAbsoluteValue
    var absoluteValue: Self { get }
    #endif

    // [_Define Documentation: SDGMathematics.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    mutating func formAbsoluteValue()
}

extension NumericAdditiveArithmetic {

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isPositive_]
    /// Returns `true` if `self` is positive.
    public var isPositive: Bool {
        return self > _0
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    public var isNegative: Bool {
        return self < _0
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isNonNegative_]
    /// Returns `true` if `self` is positive or zero.
    public var isNonNegative: Bool {
        return self ≥ _0
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isNonPositive_]
    /// Returns `true` if `self` is negative or zero.
    public var isNonPositive: Bool {
        return self ≤ _0
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    ///
    /// - MutatingVariant: formAbsoluteValue
    public var absoluteValue: Self {
        var result = self
        result.formAbsoluteValue()
        return result
    }

    /// Returns the absolute value (in conjuction with postfix `|(_:)`).
    ///
    ///     let x = −1
    ///     let y = |x|
    ///     // y == 1
    ///
    /// - Warning: The result of unpaired use is undefined.
    public static prefix func | (operand: Self) -> Self {
        return operand.absoluteValue
    }
    /// Returns the absolute value (in conjuction with prefix `|(_:)`).
    ///
    ///     let x = −1
    ///     let y = |x|
    ///     // y == 1
    ///
    /// - Warning: The result of unpaired use is undefined.
    public static postfix func | (operand: Self) -> Self {
        return operand
    }
}

extension NumericAdditiveArithmetic where Self : FloatType {
    // MARK: - where Self : FloatType

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    ///
    /// - MutatingVariant: formAbsoluteValue
    public var absoluteValue: Self {
        return Self.abs(self)
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    public mutating func formAbsoluteValue() {
        self = Self.abs(self)
    }
}

extension NumericAdditiveArithmetic where Self : IntType {
    // MARK: - where Self : IntType

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    ///
    /// - MutatingVariant: formAbsoluteValue
    public var absoluteValue: Self {
        return Swift.abs(self)
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    public mutating func formAbsoluteValue() {
        self = Swift.abs(self)
    }
}

extension NumericAdditiveArithmetic where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isPositive_]
    /// Returns `true` if `self` is positive.
    public var isPositive: Bool {
        return rawValue.isPositive
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    public var isNegative: Bool {
        return rawValue.isNegative
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isNonNegative_]
    /// Returns `true` if `self` is positive or zero.
    public var isNonNegative: Bool {
        return rawValue.isNonNegative
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isNonPositive_]
    /// Returns `true` if `self` is negative or zero.
    public var isNonPositive: Bool {
        return rawValue.isNonPositive
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.absoluteValue_]
    /// The absolute value.
    ///
    /// - MutatingVariant: formAbsoluteValue
    public var absoluteValue: Self {
        return Self(rawValue: rawValue.absoluteValue)
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    public mutating func formAbsoluteValue() {
        rawValue.formAbsoluteValue()
    }
}

extension NumericAdditiveArithmetic where Self : Negatable {
    // MARK: - where Self : Negatable

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    public mutating func formAbsoluteValue() {
        if self < _0 {
            self−=
        }
    }
}

extension NumericAdditiveArithmetic where Self : WholeNumberType {
    // MARK: - where Self : WholeNumberType

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isNegative_]
    /// Returns `true` if `self` is negative.
    public var isNegative: Bool {
        return false
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.isNonNegative_]
    /// Returns `true` if `self` is positive or zero.
    public var isNonNegative: Bool {
        return true
    }

    // [_Inherit Documentation: SDGMathematics.NumericAdditiveArithmetic.formAbsoluteValue_]
    /// Sets `self` to its absolute value.
    ///
    /// - NonmutatingVariant: |
    public mutating func formAbsoluteValue() {
        // self = self
    }
}
