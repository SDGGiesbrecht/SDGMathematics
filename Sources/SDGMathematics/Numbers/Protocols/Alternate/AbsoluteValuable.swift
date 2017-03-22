/*
 AbsoluteValuable.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension AbsoluteValuable where Self : IntegralArithmetic {
    // MARK: - where Self : IntegralArithmetic

    /// Returns the absolute value of `x`.
    ///
    /// - Parameters:
    ///     - x: The starting value.
    ///
    /// - Recommended: |
    public static func abs(_ x: Self) -> Self {
        return |x|
    }
}
