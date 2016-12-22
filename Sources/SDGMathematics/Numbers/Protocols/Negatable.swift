// Negatable.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

// swiftlint:disable ascii_hyphen_minus
/// Performs additive inversion.
///
/// - SeeAlso: `−=(_:)` (mutating variant)
///
/// - SeeAlso: (recommended over) `-(_:)`
prefix operator −
// swiftlint:enable ascii_hyphen_minus

/// Modifies the operand by additive inversion.
///
/// - SeeAlso: `−(_:)` (non‐mutating variant)
postfix operator −=

/// A type that can be additively inverted.
///
/// - Note: Unlike `SignedNumber`, `Negatable` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc.
///
/// Conformance Requirements:
///
/// - `AdditiveArithmetic`
public protocol Negatable: AdditiveArithmetic {
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - SeeAlso: `−=(_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:)`
    static prefix func −(operand: Self) -> Self
    // swiftlint:enable ascii_hyphen_minus
    
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - SeeAlso: `−(_:)` (non‐mutating variant)
    static postfix func −=(operand: inout Self)
}

extension Negatable {
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - SeeAlso: `−=(_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:)`
    public static prefix func −(operand: Self) -> Self {
        return _0 − operand
    }
    // swiftlint:enable ascii_hyphen_minus
    
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - SeeAlso: `−(_:)` (non‐mutating variant)
    public static postfix func −=(operand: inout Self) {
        operand = _0 − operand
    }
}

extension Negatable where Self : FloatType {
    // MARK: - where Self : FloatType
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - SeeAlso: `−=(_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:)`
    public static prefix func −(operand: Self) -> Self {
        return -operand
    }
    // swiftlint:enable ascii_hyphen_minus
    
    // swiftlint:disable ascii_hyphen_minus
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - SeeAlso: `−(_:)` (non‐mutating variant)
    public static postfix func −=(operand: inout Self) {
        operand = -operand
    }
    // swiftlint:enable ascii_hyphen_minus
}

extension Negatable where Self : IntType {
    // MARK: - where Self : IntType
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - SeeAlso: `−=(_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:)`
    public static prefix func −(operand: Self) -> Self {
        return -operand
    }
    // swiftlint:enable ascii_hyphen_minus
    
    // swiftlint:disable ascii_hyphen_minus
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - SeeAlso: `−(_:)` (non‐mutating variant)
    public static postfix func −=(operand: inout Self) {
        operand = -operand
    }
    // swiftlint:enable ascii_hyphen_minus
}

extension Negatable where Self : Measurement {
    // MARK: - where Self : Measurement
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - SeeAlso: `−=(_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:)`
    public static prefix func −(operand: Self) -> Self {
        return Self(rawValue: −operand.rawValue)
    }
    // swiftlint:enable ascii_hyphen_minus
    
    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - SeeAlso: `−(_:)` (non‐mutating variant)
    public static postfix func −=(operand: inout Self) {
        operand.rawValue−=
    }
}
