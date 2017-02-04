/*
 OneDimensionalVector.swift

 This source file is part of the SDGMathematics open source project.

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A one‐dimensional value that can be used with ×(_:_) and ÷(_:_:) in conjunction with a scalar.
///
/// Conformance Requirements:
///
/// - `VectorType`
/// - `static func ÷(lhs: Self, rhs: Self) -> Scalar`
public protocol OneDimensionalVector: VectorType {
    
    /// Returns the quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - SeeAlso: `÷=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `/(_:_:)`
    static func ÷(lhs: Self, rhs: Self) -> Scalar
}
