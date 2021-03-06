/*
 Bool.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension Bool : Comparable {

    private static let randomizationBit: UInt64 = 1 << 48

    // [_Example 1: Alternating Booleans_]
    /// A value a `Randomizer` can return that will result in `false`.
    ///
    /// For example:
    ///
    /// ```swift
    /// let alternating = CyclicalNumberGenerator([
    ///     Bool.falseRandomizerValue,
    ///     Bool.trueRandomizerValue
    ///     ])
    ///
    /// // Booleans created using...
    /// _ = Bool(fromRandomizer: alternating)
    /// // ...now alternate between “false” and “true”.
    /// ```
    public static let falseRandomizerValue: UInt64 = 0

    // [_Example 1: Alternating Booleans_]
    /// A value a `Randomizer` can return that will result in `true`.
    ///
    /// For example:
    ///
    /// ```swift
    /// let alternating = CyclicalNumberGenerator([
    ///     Bool.falseRandomizerValue,
    ///     Bool.trueRandomizerValue
    ///     ])
    ///
    /// // Booleans created using...
    /// _ = Bool(fromRandomizer: alternating)
    /// // ...now alternate between “false” and “true”.
    /// ```
    public static let trueRandomizerValue: UInt64 = randomizationBit

    /// Returns a random Boolean value.
    public static func random() -> Bool {
        return Bool(fromRandomizer: PseudorandomNumberGenerator.defaultGenerator)
    }

    /// Creates a random Boolean value derived from a particular randomizer.
    ///
    /// - Parameters:
    ///     - randomizer: The randomizer.
    public init(fromRandomizer randomizer: Randomizer) {
        self = randomizer.randomNumber() & Bool.randomizationBit == Bool.randomizationBit
    }

    // MARK: - Comparable

    // [_Inherit Documentation: SDGMathematics.Comparable.<_]
    /// Returns `true` if the left value is less than the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func < (lhs: Bool, rhs: Bool) -> Bool {
        if lhs == false ∧ rhs == true {
            return true
        } else {
            return false
        }
    }
}
