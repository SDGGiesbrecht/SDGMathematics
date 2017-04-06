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

// [_Inherit Documentation: SDGMathematics.RationalArithmetic.÷_]
/// Returns the (rational) quotient of the left divided by the right.
///
/// - Parameters:
///     - lhs: The dividend.
///     - rhs: The divisor.
///
/// - MutatingVariant: ×
///
/// - RecommendedOver: /
infix operator ÷: MultiplicationPrecedence

// [_Inherit Documentation: SDGMathematics.RationalArithmetic.÷=_]
/// Modifies the left by dividing it by the right.
///
/// - Parameters:
///     - lhs: The value to modify.
///     - rhs: The divisor.
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

    // [_Define Documentation: SDGMathematics.RationalArithmetic.÷_]
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

    // [_Define Documentation: SDGMathematics.RationalArithmetic.÷=_]
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

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    init(randomInRange range: Range<Self>)

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    init(randomInRange range: Range<Self>, fromRandomizer randomizer: Randomizer)
}

extension RationalArithmetic {

    // [_Inherit Documentation: SDGMathematics.RationalArithmetic.÷_]
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

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.init(randomInRange:)_]
    /// Creates a random value within a particular range.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    public init(randomInRange range: Range<Self>) {
        self.init(randomInRange: range, fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
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

    // [_Inherit Documentation: SDGMathematics.RationalArithmetic.÷_]
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

    // [_Inherit Documentation: SDGMathematics.RationalArithmetic.÷=_]
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
