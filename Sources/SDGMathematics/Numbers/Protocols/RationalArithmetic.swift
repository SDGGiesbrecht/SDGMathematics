// RationalArithmetic.swift
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

/// Performs division.
///
/// - SeeAlso: `÷=(_:_:)` (mutating variant)
///
/// - SeeAlso: (recommended over) `/(_:_:)`
infix operator ÷: MultiplicationPrecedence

// swiftlint:disable divide_and_set
/// Modifies the left by dividing it by the right.
///
/// - SeeAlso: ÷`(_:_:)` (non‐mutating variant)
///
/// - SeeAlso: (recommended over) `/=(_:_:)`
infix operator ÷=: AssignmentPrecedence
// swiftlint:enable divide_and_set

/// A type that can be used for rational arithmetic.
///
/// Conformance Requirements:
///
/// - `IntegralArithmetic`
/// - `ExpressibleByFloatLiteral`
/// - `static func ÷=(lhs: inout Self, rhs: Self)`
public protocol RationalArithmetic: ExpressibleByFloatLiteral, IntegralArithmetic {
    
    /// Returns the (rational) quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - SeeAlso: `÷=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `/(_:_:)`
    static func ÷(lhs: Self, rhs: Self) -> Self
    
    // swiftlint:disable divide_and_set
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The divisor.
    ///
    /// - SeeAlso: `÷(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `/=(_:_:)`
    static func ÷=(lhs: inout Self, rhs: Self)
    // swiftlint:enable divide_and_set
    
    /// Creates a random value within a particular range.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: Range<Self>)
    
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Precondition: `range` is not empty.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer)
}

extension RationalArithmetic {
    
    /// Returns the (rational) quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - SeeAlso: `÷=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `/(_:_:)`
    public static func ÷(lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result ÷= rhs
        return result
    }
    
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: Range<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }
    
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer) {
        
        assert(¬range.isEmpty, "Empty range.")
        
        var random = range.upperBound
        
        while random == range.upperBound {
            random = Self(randomInRange: range.lowerBound ... range.upperBound, fromRandomizer: randomizer)
        }
        
        self = random
    }
}

extension RationalArithmetic where Self : FloatType {
    // MARK: - where Self : FloatType
    
    // swiftlint:disable division
    /// Returns the (rational) quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - SeeAlso: `÷=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `/(_:_:)`
    public static func ÷(lhs: Self, rhs: Self) -> Self {
        return lhs / rhs
    }
    // swiftlint:enable division
    
    // swiftlint:disable divide_and_set
    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The divisor.
    ///
    /// - SeeAlso: `÷(_:_:)` (non‐mutating variant)
    ///
    /// - SeeAlso: (recommended over) `/=(_:_:)`
    public static func ÷=(lhs: inout Self, rhs: Self) {
        lhs /= rhs
    }
    // swiftlint:enable divide_and_set
}
