/*
 Comparable.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Comparable {

    // [_Define Documentation: SDGMathematics.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
}

// [_Inherit Documentation: SDGMathematics.Comparable.≤_]
/// Returns `true` if the left value is ordered before or the same as the right value.
///
/// - Parameters:
///     - lhs: A value to compare.
///     - rhs: Another value to compare.
///
/// - RecommendedOver: <=
infix operator ≤: ComparisonPrecedence

extension Comparable {

    // [_Define Documentation: SDGMathematics.Comparable.≤_]
    /// Returns `true` if the left value is ordered before or the same as the right value.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    ///
    /// - RecommendedOver: <=
    public static func ≤ (lhs: Self, rhs: Self) -> Bool {
        return lhs <= rhs
    }
}

// [_Inherit Documentation: SDGMathematics.Comparable.≥_]
/// Returns `true` if the left value is ordered after or the same as the right value.
///
/// - Parameters:
///     - lhs: A value to compare.
///     - rhs: Another value to compare.
///
/// - RecommendedOver: >=
infix operator ≥: ComparisonPrecedence

extension Comparable {

    // [_Define Documentation: SDGMathematics.Comparable.≥_]
    /// Returns `true` if the left value is ordered after or the same as the right value.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    ///
    /// - RecommendedOver: >=
    public static func ≥ (lhs: Self, rhs: Self) -> Bool {
        return lhs >= rhs
    }
}

// [_Inherit Documentation: SDGMathematics.Comparable.≤=_]
/// Reduces the value of `lhs` so that it satisfies `lhs ≤ rhs`.
///
/// This is accomplished by changing the value of `lhs` to match the value of `rhs` if and only if `lhs` does not already satisfy `lhs ≤ rhs`.
///
/// In other words, `lhs` is changed to the minimum of `lhs` and `rhs`.
///
/// For example:
///
/// ```swift
/// let numberOfRolls = 5
/// var highestRoll = 1
/// for _ in 1 ... numberOfRolls {
///     highestRoll ≥= rollDie()
/// }
/// print("After rolling the die \(numberOfRolls) time(s), the highest roll was \(highestRoll).")
/// // Prints, for example, “After rolling the die 5 time(s), the highest roll was 4.”
///
/// // In this example, rollDie() represents a function that randomly returns an Int between 1 and 6 inclusive. In each iteration of the for loop, a new random number is generated, and if it is greater than highestRoll’s existing value, ≤= changes highestRoll to reflect the new high.
/// ```
///
/// - Parameters:
///     - lhs: The value to decrease.
///     - rhs: The desired maximum for the value.
///
/// - NonmutatingVariant: min
infix operator ≤=: AssignmentPrecedence

extension Comparable {

    // [_Define Documentation: SDGMathematics.Comparable.≤=_]
    // [_Example 1: ≥=_]
    /// Reduces the value of `lhs` so that it satisfies `lhs ≤ rhs`.
    ///
    /// This is accomplished by changing the value of `lhs` to match the value of `rhs` if and only if `lhs` does not already satisfy `lhs ≤ rhs`.
    ///
    /// In other words, `lhs` is changed to the minimum of `lhs` and `rhs`.
    ///
    /// For example:
    ///
    /// ```swift
    /// let numberOfRolls = 5
    /// var highestRoll = 1
    /// for _ in 1 ... numberOfRolls {
    ///     highestRoll ≥= rollDie()
    /// }
    /// print("After rolling the die \(numberOfRolls) time(s), the highest roll was \(highestRoll).")
    /// // Prints, for example, “After rolling the die 5 time(s), the highest roll was 4.”
    ///
    /// // In this example, rollDie() represents a function that randomly returns an Int between 1 and 6 inclusive. In each iteration of the for loop, a new random number is generated, and if it is greater than highestRoll’s existing value, ≤= changes highestRoll to reflect the new high.
    /// ```
    ///
    /// - Parameters:
    ///     - lhs: The value to decrease.
    ///     - rhs: The desired maximum for the value.
    ///
    /// - NonmutatingVariant: min
    public static func ≤= (lhs: inout Self, rhs: Self) {
        if lhs > rhs {
            lhs = rhs
        }
    }
}

// [_Inherit Documentation: SDGMathematics.Comparable.≥=_]
/// Increases the value of `lhs` so that it satisfies `lhs ≥ rhs`.
///
/// This is accomplished by changing the value of `lhs` to match the value of `rhs` if and only if `lhs` does not already satisfy `lhs ≥ rhs`.
///
/// In other words, `lhs` is changed to the maximum of `lhs` and `rhs`.
///
/// For example:
///
/// ```swift
/// let numberOfRolls = 5
/// var highestRoll = 1
/// for _ in 1 ... numberOfRolls {
///     highestRoll ≥= rollDie()
/// }
/// print("After rolling the die \(numberOfRolls) time(s), the highest roll was \(highestRoll).")
/// // Prints, for example, “After rolling the die 5 time(s), the highest roll was 4.”
///
/// // In this example, rollDie() represents a function that randomly returns an Int between 1 and 6 inclusive. In each iteration of the for loop, a new random number is generated, and if it is greater than highestRoll’s existing value, ≤= changes highestRoll to reflect the new high.
/// ```
///
/// - Parameters:
///     - lhs: The value to increase.
///     - rhs: The desired minimum for the value.
///
/// - NonmutatingVariant: max
infix operator ≥=: AssignmentPrecedence

extension Comparable {

    // [_Define Documentation: SDGMathematics.Comparable.≥=_]
    // [_Example 1: ≥=_]
    /// Increases the value of `lhs` so that it satisfies `lhs ≥ rhs`.
    ///
    /// This is accomplished by changing the value of `lhs` to match the value of `rhs` if and only if `lhs` does not already satisfy `lhs ≥ rhs`.
    ///
    /// In other words, `lhs` is changed to the maximum of `lhs` and `rhs`.
    ///
    /// For example:
    ///
    /// ```swift
    /// let numberOfRolls = 5
    /// var highestRoll = 1
    /// for _ in 1 ... numberOfRolls {
    ///     highestRoll ≥= rollDie()
    /// }
    /// print("After rolling the die \(numberOfRolls) time(s), the highest roll was \(highestRoll).")
    /// // Prints, for example, “After rolling the die 5 time(s), the highest roll was 4.”
    ///
    /// // In this example, rollDie() represents a function that randomly returns an Int between 1 and 6 inclusive. In each iteration of the for loop, a new random number is generated, and if it is greater than highestRoll’s existing value, ≤= changes highestRoll to reflect the new high.
    /// ```
    ///
    /// - Parameters:
    ///     - lhs: The value to increase.
    ///     - rhs: The desired minimum for the value.
    ///
    /// - NonmutatingVariant: max
    public static func ≥= (lhs: inout Self, rhs: Self) {
        if lhs < rhs {
            lhs = rhs
        }
    }
}

extension Comparable where Self : Measurement {
    // MARK: - where Self : Measurement

    // [_Inherit Documentation: SDGMathematics.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
