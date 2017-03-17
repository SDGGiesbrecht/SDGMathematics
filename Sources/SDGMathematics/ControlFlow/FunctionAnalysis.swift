/*
 FunctionAnalysis.swift

 This source file is part of the SDGMathematics open source project.
 https://github.com/SDGGiesbrecht/SDGMathematics

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

// MARK: - Function Analysis

// Local Extremes

private func findLocalExtreme<I : OneDimensionalPoint, O>(near location: I, within bounds: CountableClosedRange<I>?, inFunction function: (I) -> O, isCloser: (O, O) -> Bool) -> I where I.Vector : IntegerType {
    var location = location

    assert(bounds == nil ∨ bounds!.contains(location), "Location (\(location)) out of bounds (\(bounds)).")

    while location ≠ bounds?.upperBound ∧ isCloser(function(location.successor()), function(location)) {
        location = location.successor()
    }

    while location ≠ bounds?.lowerBound ∧ isCloser(function(location.predecessor()), function(location)) {
        location = location.predecessor()
    }

    return location
}

/// Returns the input (*x*) corresponding to the local maximum output (*y*) near `location`.
///
/// This function automates a guess‐and‐check strategy and is useful for inverting otherwise one‐way functions. See the related function `findLocalMaximum(near:bounds:inFunction:)` for an example.
///
/// - Warning: Behaviour is undefined when:
///     - `location` is at a local minimum (e.g. when `location` is `0` in `{ (−10 ..< 10).contains($0) ? $0 ↑ 2 : −($0 ↑ 2) }`), or
///     - two or more adjascent inputs share the maximum output (e.g. `{ (−10 ..< 10).contains($0) ? 1 : −(|$0|) }`).
///
/// - Precondition: If `bounds ≠ nil`, a local maximum must be known to exist, otherwise execution will get stuck in an infinite loop. An example of a violation would be `findLocalMaximum(near: 0, inFunction: {$0})`.
///
/// - Parameters:
///     - location: A location (*x*) where the slope approaches the searched‐for local maximum.
///     - bounds: An optional domain (for *x*) to stay within.
///     - function: The function to analyze.
/// - Returns: The input (*x*) that results in the local maximum (*y*).
public func findLocalMaximum<I : OneDimensionalPoint, O : Comparable>(near location: I, within bounds: CountableClosedRange<I>? = nil, inFunction function: (I) -> O) -> I where I.Vector : IntegerType {
    return findLocalExtreme(near: location, within: bounds, inFunction: function, isCloser: { $0 ≥ $1 })
}

/// Returns the input (*x*) corresponding to the local minimum output (*y*) near `location`.
///
/// This function automates a guess‐and‐check strategy and is useful for inverting otherwise one‐way functions. For example, finding the approximate square root of 120 can be done using only simpler arithmetic like this:
///
///     let x = findLocalMinimum(near: 10, inFunction: { |($0 × $0 − 120)| })
///     print(x)
///     // Prints “11”
///
/// In this example `findLocalMinimum(near:bounds:inFunction:)` guesses square roots, beginning with `10`, and checks how close each guess is by inputting it into `{ |($0 × $0 − 120)| }`. (`$0 × $0` squares the guess, and `|(`*x*` − 120)|` outputs how far that square is from 120.) `findLocalMinimum(near:bounds:inFunction)` increments and decrements its guess until the outputted distance from 120 stops decreasing. 10 yields 20, 11 yields 1, 12 yields 24, and at this point the local minimum has been discovered (i.e. 1) and its corresponding input is returned (i.e. 11).
///
/// - Warning: Behaviour is undefined when:
///     - `location` is at a local maximum (e.g. when `location` is `0` in `{ (−10 ..< 10).contains($0) ? −($0 ↑ 2) : $0 ↑ 2 }`), or
///     - two or more adjascent inputs share the minimum output (e.g. `{ (−10 ..< 10).contains($0) ? −1 : |$0| }`).
///
/// - Precondition: If `bounds ≠ nil`, a local minimum must be known to exist, otherwise execution will get stuck in an infinite loop. An example of a violation would be `findLocalMinimum(near: 0, inFunction: {$0})`.
///
/// - Parameters:
///     - location: A location (*x*) where the slope approaches the searched‐for local minimum.
///     - bounds: An optional domain (for *x*) to stay within.
///     - function: The function to analyze.
/// - Returns: The input (*x*) that results in the local minimum (*y*).
public func findLocalMinimum<I : OneDimensionalPoint, O : Comparable>(near location: I, within bounds: CountableClosedRange<I>? = nil, inFunction function: (I) -> O) -> I where I.Vector : IntegerType {
    return findLocalExtreme(near: location, within: bounds, inFunction: function, isCloser: { $0 ≤ $1 })
}
