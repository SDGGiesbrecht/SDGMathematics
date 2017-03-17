/*
 Subtractable.swift

 This source file is part of the SDGMathematics open source project.
 https://github.com/SDGGiesbrecht/SDGMathematics

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Subtracts the right from the left.
///
/// - MutatingVariant: −=
///
/// - RecommendedOver: -
infix operator −: AdditionPrecedence

/// Modifies the left by subtracting the right.
///
/// - NonmutatingVariant: −
///
/// - RecommendedOver: -=
infix operator −=: AssignmentPrecedence

/// A type that can do scalar subtraction.
///
/// - Note: `Subtractable` is distinct from `Negatable` to allow whole number types to perform subtraction.
///
/// - Note: Unlike `SignedNumber`, `Subtractable` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc.
///
/// Conformance Requirements:
///
/// - `Addable`
/// - `static func −= (lhs: inout Self, rhs: Self)`
public protocol Subtractable : Addable {

    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    static func − (lhs: Self, rhs: Self) -> Self

    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    static func −= (lhs: inout Self, rhs: Self)
}

extension Subtractable {

    fileprivate static func subtractAsSubtractable(_ lhs: Self, _ rhs: Self) -> Self {
        var result = lhs
        result −= rhs
        return result
    }
    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return subtractAsSubtractable(lhs, rhs)
    }
}

extension FloatType {
    // Disambiguate FloatingPoint.−= vs Strideable.−=
    fileprivate static func subtractAndAssignAsFloatingPoint(_ lhs: inout Self, _ rhs: Self) {
        lhs -= rhs
    }
}
extension Subtractable where Self : FloatType, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : FloatType, Vector == Self, Stride == Self

    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
    }

    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout Self, rhs: Self) {
        subtractAndAssignAsFloatingPoint(&lhs, rhs)
    }
}

extension Subtractable where Self : IntType /* Self.Stride ≠ Self */ {
    // MARK: - where Self : IntType

    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
    }

    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout Self, rhs: Self) {
        lhs -= rhs
    }
}

extension Subtractable where Self : IntType, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : IntType, Vector == Self, Stride == Self

    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
        // Disambiguate Subtractable(where IntType).− vs Subtractable(where PointType, Strideable, Stride == Self).−
    }
}

extension Subtractable where Self : Measurement {
    // MARK: - where Self : Measurement

    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return Self(rawValue: lhs.rawValue − rhs.rawValue)
    }

    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout Self, rhs: Self) {
        lhs.rawValue −= rhs.rawValue
    }
}

extension Subtractable where Self : PointType, Self.Vector == Self {
    // MARK: - where Self : PointType, Vector == Self

    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        // Disambiguate Subtractable.− vs PointType.−
        return subtractAsSubtractable(lhs, rhs)
    }
}

extension Subtractable where Self : PointType, Self : Strideable, Self.Vector == Self, Self.Stride == Self {
    // MARK: - where Self : PointType, Self : Strideable, Vector == Self, Stride == Self

    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        // Disambiguate Subtractable(where PointType).− vs PointType(where Strideable).−
        return subtractAsSubtractable(lhs, rhs)
    }
}

extension Subtractable where Self : UIntType {
    // MARK: - where Self : UIntType

    /// Returns the difference of the left minus the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - MutatingVariant: −=
    ///
    /// - RecommendedOver: -
    public static func − (lhs: Self, rhs: Self) -> Self {
        return lhs - rhs
    }

    /// Subtracts the right from the left.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The value to subtract.
    ///
    /// - NonmutatingVariant: −
    ///
    /// - RecommendedOver: -=
    public static func −= (lhs: inout Self, rhs: Self) {
        lhs -= rhs
    }
}
