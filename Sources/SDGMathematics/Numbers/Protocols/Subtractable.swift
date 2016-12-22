// Subtractable.swift
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
/// Subtracts the right from the left.
///
/// - SeeAlso: `−=(_:_:)` (mutating variant)
///
/// - SeeAlso: (recommended over) `-(_:_:)`
infix operator −: AdditionPrecedence
// swiftlint:enable ascii_hyphen_minus

// swiftlint:disable subtract_and_set
/// Modifies the left by subtracting the right.
///
/// - SeeAlso: `−(_:_:)` (non‐mutating variant)
///
/// - SeeAlso: (recommended over) `-=(_:_:)`
infix operator −=: AssignmentPrecedence
// swiftlint:enable subtract_and_set

/// A type that can do scalar subtraction.
///
/// - Note: `Subtractable` is distinct from `Negatable` to allow whole number types to perform subtraction.
///
/// - Note: Unlike `SignedNumber`, `Subtractable` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc.
///
/// Conformance Requirements:
///
/// - `Addable`
/// - `static func −=(lhs: inout Self, rhs: Self)`
public protocol Subtractable: Addable {
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:_:)`
    static func −(lhs: Self, rhs: Self) -> Self
    // swiftlint:enable ascii_hyphen_minus
    
    // swiftlint:disable subtract_and_set
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-=(_:_:)`
    static func −=(lhs: inout Self, rhs: Self)
    // swiftlint:enable subtract_and_set
}

extension Subtractable {
    
    fileprivate static func subtractAsSubtractable(_ lhs: Self, _ rhs: Self) -> Self {
        var result = lhs
        result −= rhs
        return result
    }
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:_:)`
    public static func −(lhs: Self, rhs: Self) -> Self {
        return subtractAsSubtractable(lhs, rhs)
    }
    // swiftlint:enable ascii_hyphen_minus
}

extension FloatType {
    // swiftlint:disable subtract_and_set
    // Disambiguate FloatingPoint.-= vs Strideable.-=
    fileprivate static func subtractAndAssignAsFloatingPoint(_ lhs: inout Self, _ rhs: Self) {
        lhs -= rhs
    }
    // swiftlint:enable subtract_and_set
}
extension Subtractable where Self : FloatType, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : FloatType, Vector == Self, Stride == Self
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:_:)`
    public static func −(lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
    }
    // swiftlint:enable ascii_hyphen_minus
    
    // swiftlint:disable subtract_and_set
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-=(_:_:)`
    public static func −=(lhs: inout Self, rhs: Self) {
        subtractAndAssignAsFloatingPoint(&lhs, rhs)
    }
    // swiftlint:enable subtract_and_set
}

extension Subtractable where Self : IntType /* Self.Stride ≠ Self */ {
    // MARK: - where Self : IntType
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:_:)`
    public static func −(lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
    }
    // swiftlint:enable ascii_hyphen_minus
    
    // swiftlint:disable subtract_and_set
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-=(_:_:)`
    public static func −=(lhs: inout Self, rhs: Self) {
        lhs -= rhs
    }
    // swiftlint:enable subtract_and_set
}

extension Subtractable where Self : IntType, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : IntType, Vector == Self, Stride == Self
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:_:)`
    public static func −(lhs: Self, rhs: Self) -> Self {
        // Disambiguate Subtractable(where IntType).− vs Subtractable(where PointType, Strideable, Stride == Self).−
        return lhs - rhs
    }
    // swiftlint:enable ascii_hyphen_minus
}

extension Subtractable where Self : Measurement {
    // MARK: - where Self : Measurement
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:_:)`
    public static func −(lhs: Self, rhs: Self) -> Self {
        return Self(rawValue: lhs.rawValue − rhs.rawValue)
    }
    // swiftlint:enable ascii_hyphen_minus
    
    // swiftlint:disable subtract_and_set
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-=(_:_:)`
    public static func −=(lhs: inout Self, rhs: Self) {
        lhs.rawValue −= rhs.rawValue
    }
    // swiftlint:enable subtract_and_set
}

extension Subtractable where Self : PointType, Self.Vector == Self {
    // MARK: - where Self : PointType, Vector == Self
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:_:)`
    public static func −(lhs: Self, rhs: Self) -> Self {
        // Disambiguate Subtractable.− vs PointType.−
        return subtractAsSubtractable(lhs, rhs)
    }
    // swiftlint:enable ascii_hyphen_minus
}

extension Subtractable where Self : PointType, Self : Strideable, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : PointType, Self : Strideable, Vector == Self, Stride == Self
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:_:)`
    public static func −(lhs: Self, rhs: Self) -> Self {
        // Disambiguate Subtractable(where PointType).− vs PointType(where Strideable).−
        return subtractAsSubtractable(lhs, rhs)
    }
    // swiftlint:enable ascii_hyphen_minus
}

extension Subtractable where Self : UIntType {
    // MARK: - where Self : UIntType
    
    // swiftlint:disable ascii_hyphen_minus
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-(_:_:)`
    public static func −(lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
    }
    // swiftlint:enable ascii_hyphen_minus
    
    // swiftlint:disable subtract_and_set
    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `-=(_:_:)`
    public static func −=(lhs: inout Self, rhs: Self) {
        lhs -= rhs
    }
    // swiftlint:enable subtract_and_set
}
