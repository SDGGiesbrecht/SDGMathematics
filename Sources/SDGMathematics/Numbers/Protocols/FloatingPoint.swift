// FloatingPoint.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

extension FloatingPoint {
    // Disambiguate FloatingPoint.rounded(_:) vs WholeArithmetic.rounded(_:)
    fileprivate func roundedAsFloatingPoint(_ rule: FloatingPointRoundingRule) -> Self {
        return rounded(rule)
    }
}
extension FloatingPoint where Self : WholeArithmetic {
    // MARK: - where Self : WholeArithmetic
    
    /// Returns the value rounded to an integral value using the specified rounding rule.
    ///
    /// - Parameters:
    ///     - rule: The rounding rule follow.
    ///
    /// - SeeAlso: `round(_:)` (mutating variant)
    public func rounded(_ rule: FloatingPointRoundingRule) -> Self {
        // Disambiguate FloatingPoint.rounded(_:) vs WholeArithmetic.rounded(_:)
        return roundedAsFloatingPoint(rule)
    }
}
