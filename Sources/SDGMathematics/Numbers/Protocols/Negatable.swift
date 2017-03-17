/*
 Negatable.swift

 This source file is part of the SDGMathematics open source project.
 https://github.com/SDGGiesbrecht/SDGMathematics

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Performs additive inversion.
///
/// - MutatingVariant: −=
///
/// - RecommendedOver: -
prefix operator −

/// Modifies the operand by additive inversion.
///
/// - NonmutatingVariant: −
postfix operator −=

/// A type that can be additively inverted.
///
/// - Note: Unlike `SignedNumber`, `Negatable` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc.
///
/// Conformance Requirements:
///
/// - `AdditiveArithmetic`
public protocol Negatable : AdditiveArithmetic {

    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    static prefix func − (operand: Self) -> Self

    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    static postfix func −= (operand: inout Self)
}

extension Negatable {

    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static prefix func − (operand: Self) -> Self {
        return _0 − operand
    }

    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout Self) {
        operand = _0 − operand
    }
}

extension Negatable where Self : FloatType {
    // MARK: - where Self : FloatType

    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static prefix func − (operand: Self) -> Self {
        return -operand
    }

    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout Self) {
        operand = -operand
    }
}

extension Negatable where Self : IntType {
    // MARK: - where Self : IntType

    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static prefix func − (operand: Self) -> Self {
        return -operand
    }

    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout Self) {
        operand = -operand
    }
}

extension Negatable where Self : Measurement {
    // MARK: - where Self : Measurement

    /// Returns the additive inverse of the operand.
    ///
    /// - Parameters:
    ///     - operand: The value to invert.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static prefix func − (operand: Self) -> Self {
        return Self(rawValue: −operand.rawValue)
    }

    /// Sets the operand to its additive inverse.
    ///
    /// - Parameters:
    ///     - operand: The value to modify by inversion.
    ///
    /// - NonmutatingVariant: −
    public static postfix func −= (operand: inout Self) {
        operand.rawValue−=
    }
}
