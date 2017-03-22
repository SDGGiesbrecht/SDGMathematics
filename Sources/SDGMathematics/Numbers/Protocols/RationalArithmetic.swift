/*
 RationalArithmetic.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// Performs division.
///
/// - MutatingVariant: ×
///
/// - RecommendedOver: /
infix operator ÷: MultiplicationPrecedence

/// Modifies the left by dividing it by the right.
///
/// - NonmutatingVariant: ÷
///
/// - RecommendedOver: /=
infix operator ÷=: AssignmentPrecedence

/// A type that can be used for rational arithmetic.
///
/// Conformance Requirements:
///
/// - `IntegralArithmetic`
/// - `ExpressibleByFloatLiteral`
/// - `static func ÷= (lhs: inout Self, rhs: Self)`
public protocol RationalArithmetic : ExpressibleByFloatLiteral, IntegralArithmetic {

    /// Returns the (rational) quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - MutatingVariant: ×
    ///
    /// - RecommendedOver: /
    static func ÷ (lhs: Self, rhs: Self) -> Self

    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The divisor.
    ///
    /// - NonmutatingVariant: ÷
    ///
    /// - RecommendedOver: /=
    static func ÷= (lhs: inout Self, rhs: Self)

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
    /// - MutatingVariant: ×
    ///
    /// - RecommendedOver: /
    public static func ÷ (lhs: Self, rhs: Self) -> Self {
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

    /// Returns the (rational) quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - MutatingVariant: ×
    ///
    /// - RecommendedOver: /
    public static func ÷ (lhs: Self, rhs: Self) -> Self {
        return lhs / rhs
    }

    /// Modifies the left by dividing it by the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The divisor.
    ///
    /// - NonmutatingVariant: ÷
    ///
    /// - RecommendedOver: /=
    public static func ÷= (lhs: inout Self, rhs: Self) {
        lhs /= rhs
    }
}
