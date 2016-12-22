// SignedNumber.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

extension SignedNumber where Self : IntegralArithmetic {
    // MARK: - where Self : IntegralArithmetic
    
    // swiftlint:disable hyphen_minus
    /// Returns the result of negating `x`.
    ///
    /// - Parameters:
    ///     - x: The value to negate.
    ///
    /// - SeeAlso: `−(_:)` (recommended)
    public static prefix func -(x: Self) -> Self {
        return −x
    }
    // swiftlint:enable hyphen_minus
    
    // swiftlint:disable hyphen_minus
    /// Returns the difference between `lhs` and `rhs`.
    ///
    /// - Parameters:
    ///     - lhs: The starting value.
    ///     - rhs: The value to subtract.
    ///
    /// - SeeAlso: `−(_:_:)` (recommended)
    public static func -(lhs: Self, rhs: Self) -> Self {
        return lhs − rhs
    }
    // swiftlint:enable hyphen_minus
}
