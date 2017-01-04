// NumericAdditiveArithmetic.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

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
public protocol NumericAdditiveArithmetic: AdditiveArithmetic, Comparable {
    
    // MARK: - Classification
    
    // swiftlint:disable disjunction
    #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
    // swiftlint:enable disjunction
    // swiftlint:disable not
    // !!!!!BUG!!!!! These optimizable properties are temporarily excluded from Linux as a workaround for a compiler bug (Swift 3.0).
    // swiftlint:enable not
    
    /// Returns `true` if `self` is positive.
    var isPositive: Bool { get }
    
    /// Returns `true` if `self` is negative.
    var isNegative: Bool { get }
    
    /// Returns `true` if `self` is positive or zero.
    var isNonNegative: Bool { get }
    
    /// Returns `true` if `self` is negative or zero.
    var isNonPositive: Bool { get }
    
    // MARK: - Operations
    
    /// The absolute value.
    ///
    /// - SeeAlso: `formAbsoluteValue()` (mutating variant)
    var absoluteValue: Self { get }
    #endif
    
    /// Sets `self` to its absolute value.
    ///
    /// - SeeAlso: `|x|` (non‐mutating variant)
    mutating func formAbsoluteValue()
}

extension NumericAdditiveArithmetic {
    
    /// Returns `true` if `self` is positive.
    public var isPositive: Bool {
        return self > _0
    }
    
    /// Returns `true` if `self` is negative.
    public var isNegative: Bool {
        return self < _0
    }
    
    /// Returns `true` if `self` is positive or zero.
    public var isNonNegative: Bool {
        return self ≥ _0
    }
    
    /// Returns `true` if `self` is negative or zero.
    public var isNonPositive: Bool {
        return self ≤ _0
    }
    
    /// The absolute value.
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
    public static prefix func |(operand: Self) -> Self {
        return operand.absoluteValue
    }
    /// Returns the absolute value (in conjuction with prefix `|(_:)`).
    ///
    ///     let x = −1
    ///     let y = |x|
    ///     // y == 1
    ///
    /// - Warning: The result of unpaired use is undefined.
    public static postfix func |(operand: Self) -> Self {
        return operand
    }
}

extension NumericAdditiveArithmetic where Self : FloatType {
    // MARK: - where Self : FloatType
    
    /// The absolute value.
    public var absoluteValue: Self {
        return Self.abs(self)
    }
    
    /// Sets `self` to its absolute value.
    public mutating func formAbsoluteValue() {
        self = Self.abs(self)
    }
}

extension NumericAdditiveArithmetic where Self : IntType {
    // MARK: - where Self : IntType
    
    /// The absolute value.
    public var absoluteValue: Self {
        return Swift.abs(self)
    }
    
    /// Sets `self` to its absolute value.
    public mutating func formAbsoluteValue() {
        self = Swift.abs(self)
    }
}

extension NumericAdditiveArithmetic where Self : Measurement {
    // MARK: - where Self : Measurement
    
    /// Returns `true` if `self` is positive.
    public var isPositive: Bool {
        return rawValue.isPositive
    }
    
    /// Returns `true` if `self` is negative.
    public var isNegative: Bool {
        return rawValue.isNegative
    }
    
    /// Returns `true` if `self` is positive or zero.
    public var isNonNegative: Bool {
        return rawValue.isNonNegative
    }
    
    /// Returns `true` if `self` is negative or zero.
    public var isNonPositive: Bool {
        return rawValue.isNonPositive
    }
    
    /// The absolute value.
    ///
    /// - SeeAlso: `formAbsoluteValue()` (mutating variant)
    public var absoluteValue: Self {
        return Self(rawValue: rawValue.absoluteValue)
    }
    
    /// Sets `self` to its absolute value.
    ///
    /// - SeeAlso: `|x|` (non‐mutating variant)
    public mutating func formAbsoluteValue() {
        rawValue.formAbsoluteValue()
    }
}

extension NumericAdditiveArithmetic where Self : Negatable {
    // MARK: - where Self : Negatable
    
    /// Sets `self` to its absolute value.
    public mutating func formAbsoluteValue() {
        if self < _0 {
            self−=
        }
    }
}

extension NumericAdditiveArithmetic where Self : WholeNumberType {
    // MARK: - where Self : WholeNumberType
    
    /// Returns `true` if `self` is negative.
    public var isNegative: Bool {
        return false
    }
    
    /// Returns `true` if `self` is positive or zero.
    public var isNonNegative: Bool {
        return true
    }
    
    /// Sets `self` to its absolute value.
    public mutating func formAbsoluteValue() {
        // self = self
    }
}
