/*
 AdditiveArithmetic.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A value that can be added and subtracted.
///
/// - Note: Unlike `SignedNumber`, `AdditiveArithmetic` types do not need to conform to `Comparable`, allowing conformance by two‐dimensional vectors, etc. For additional behaviour specific to one‐dimensional types, see 	`NumericAdditiveArithmetic`.
///
/// Conformance Requirements:
///
/// - `Equatable`
/// - `Subtractable`
/// - `ExpressibleByIntegerLiteral` or `static var additiveIdentity: Self { get }`
public protocol AdditiveArithmetic : Equatable, Subtractable {

    // [_Define Documentation: SDGMathematics.AdditiveArithmetic.additiveIdentity_]
    /// The additive identity (origin).
    static var additiveIdentity: Self { get }
}

// MARK: - Additive Arithmetic

/// The additive identity of the desired return type.
///
/// - Note: This is an alias for `N.additiveIdentity` to improve the legibility of code involving mathematical equations.
public func _0<N : AdditiveArithmetic>() -> N {
    return N._0
}

extension AdditiveArithmetic {

    /// The additive identity.
    ///
    /// - Note: This is an alias for `Self.additiveIdentity` to improve the legibility of code involving mathematical equations.
    public static var _0: Self {
        return additiveIdentity
    }

    /// The additive identity.
    ///
    /// - Note: This is an alias for `Self.additiveIdentity` to improve the legibility of code involving mathematical equations.
    public var _0: Self {
        return Self._0
    }
}

extension AdditiveArithmetic where Self : ExpressibleByIntegerLiteral {
    // MARK: - where Self : ExpressibleByIntegerLiteral

    // [_Inherit Documentation: SDGMathematics.AdditiveArithmetic.additiveIdentity_]
    /// The additive identity (origin).
    public static var additiveIdentity: Self {
        return 0
    }
}

extension AdditiveArithmetic where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGMathematics.AdditiveArithmetic.additiveIdentity_]
    /// The additive identity (origin).
    public static var additiveIdentity: Self {
        return Self(rawValue: 0)
    }
}
