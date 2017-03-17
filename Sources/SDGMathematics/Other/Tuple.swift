/*
 Tuple.swift

 This source file is part of the SDGMathematics open source project.
 https://github.com/SDGGiesbrecht/SDGMathematics

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Tuples

/// Returns `true` if the left tuple is ordered before or the same as the right tuple in a lexicographical ordering.
///
/// - Parameters:
///     - lhs: A tuple to compare.
///     - rhs: Another tuple to compare.
///
/// - RecommendedOver: <=
public func ≤ <A : Comparable, B : Comparable>(lhs: (A, B), rhs: (A, B)) -> Bool {
    return lhs <= rhs
}

/// Returns `true` if the left tuple is ordered before or the same as the right tuple in a lexicographical ordering.
///
/// - Parameters:
///     - lhs: A tuple to compare.
///     - rhs: Another tuple to compare.
///
/// - RecommendedOver: <=
public func ≤ <A : Comparable, B : Comparable, C : Comparable>(lhs: (A, B, C), rhs: (A, B, C)) -> Bool {
    return lhs <= rhs
}

/// Returns `true` if the left tuple is ordered before or the same as the right tuple in a lexicographical ordering.
///
/// - Parameters:
///     - lhs: A tuple to compare.
///     - rhs: Another tuple to compare.
///
/// - RecommendedOver: <=
public func ≤ <A : Comparable, B : Comparable, C : Comparable, D : Comparable>(lhs: (A, B, C, D), rhs: (A, B, C, D)) -> Bool {
    return lhs <= rhs
}

/// Returns `true` if the left tuple is ordered before or the same as the right tuple in a lexicographical ordering.
///
/// - Parameters:
///     - lhs: A tuple to compare.
///     - rhs: Another tuple to compare.
///
/// - RecommendedOver: <=
public func ≤ <A : Comparable, B : Comparable, C : Comparable, D : Comparable, E : Comparable>(lhs: (A, B, C, D, E), rhs: (A, B, C, D, E)) -> Bool {
    return lhs <= rhs
}

/// Returns `true` if the left tuple is ordered before or the same as the right tuple in a lexicographical ordering.
///
/// - Parameters:
///     - lhs: A tuple to compare.
///     - rhs: Another tuple to compare.
///
/// - RecommendedOver: <=
public func ≤ <A : Comparable, B : Comparable, C : Comparable, D : Comparable, E : Comparable, F : Comparable>(lhs: (A, B, C, D, E, F), rhs: (A, B, C, D, E, F)) -> Bool {
    return lhs <= rhs
}

/// Returns `true` if the left tuple is ordered after or the same as the right tuple in a lexicographical ordering.
///
/// - Parameters:
///     - lhs: A tuple to compare.
///     - rhs: Another tuple to compare.
///
/// - RecommendedOver: >=
public func ≥ <A : Comparable, B : Comparable>(lhs: (A, B), rhs: (A, B)) -> Bool {
    return lhs >= rhs
}

/// Returns `true` if the left tuple is ordered after or the same as the right tuple in a lexicographical ordering.
///
/// - Parameters:
///     - lhs: A tuple to compare.
///     - rhs: Another tuple to compare.
///
/// - RecommendedOver: >=
public func ≥ <A : Comparable, B : Comparable, C : Comparable>(lhs: (A, B, C), rhs: (A, B, C)) -> Bool {
    return lhs >= rhs
}

/// Returns `true` if the left tuple is ordered after or the same as the right tuple in a lexicographical ordering.
///
/// - Parameters:
///     - lhs: A tuple to compare.
///     - rhs: Another tuple to compare.
///
/// - RecommendedOver: >=
public func ≥ <A : Comparable, B : Comparable, C : Comparable, D : Comparable>(lhs: (A, B, C, D), rhs: (A, B, C, D)) -> Bool {
    return lhs >= rhs
}

/// Returns `true` if the left tuple is ordered after or the same as the right tuple in a lexicographical ordering.
///
/// - Parameters:
///     - lhs: A tuple to compare.
///     - rhs: Another tuple to compare.
///
/// - RecommendedOver: >=
public func ≥ <A : Comparable, B : Comparable, C : Comparable, D : Comparable, E : Comparable>(lhs: (A, B, C, D, E), rhs: (A, B, C, D, E)) -> Bool {
    return lhs >= rhs
}

/// Returns `true` if the left tuple is ordered after or the same as the right tuple in a lexicographical ordering.
///
/// - Parameters:
///     - lhs: A tuple to compare.
///     - rhs: Another tuple to compare.
///
/// - RecommendedOver: >=
public func ≥ <A : Comparable, B : Comparable, C : Comparable, D : Comparable, E : Comparable, F : Comparable>(lhs: (A, B, C, D, E, F), rhs: (A, B, C, D, E, F)) -> Bool {
    return lhs >= rhs
}
