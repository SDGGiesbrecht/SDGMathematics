/*
 VectorType.swift

 This source file is part of the SDGMathematics open source project.
 https://github.com/SDGGiesbrecht/SDGMathematics

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An value that can be used with ×(_:_) and ÷(_:_:) in conjunction with a scalar.
///
/// Conformance Requirements:
///
/// - `AdditiveArithmetic`
/// - `static func ×=(lhs: inout Self, rhs: Scalar)`
/// - `static func ÷=(lhs: inout Self, rhs: Scalar)`
public protocol VectorType: AdditiveArithmetic {
    
    // The scalar type.
    associatedtype Scalar
    
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: A scalar coefficient.
    ///
    /// - SeeAlso: `×=(_:_:)` (mutating variant)
    static func ×(lhs: Self, rhs: Scalar) -> Self
    
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A scalar coefficient.
    ///     - rhs: A value.
    static func ×(lhs: Scalar, rhs: Self) -> Self
    
    /// Modifies the left by multiplication with the right.
    ///
    /// - Parameters:
    ///     - lhs: The value to modify.
    ///     - rhs: The scalar coefficient by which to multiply.
    ///
    /// - SeeAlso: `×(_:_:)` (non‐mutating variant)
    static func ×=(lhs: inout Self, rhs: Scalar)
    
    /// Returns the quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - SeeAlso: `÷=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `/(_:_:)`
    static func ÷(lhs: Self, rhs: Scalar) -> Self
    
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
    static func ÷=(lhs: inout Self, rhs: Scalar)
    // swiftlint:enable divide_and_set
}

extension VectorType {
    
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: A scalar coefficient.
    ///
    /// - SeeAlso: `×=(_:_:)` (mutating variant)
    public static func ×(lhs: Self, rhs: Scalar) -> Self {
        var result = lhs
        result ×= rhs
        return result
    }
    
    /// Returns the product of the left times the right.
    ///
    /// - Parameters:
    ///     - lhs: A scalar coefficient.
    ///     - rhs: A value.
    public static func ×(lhs: Scalar, rhs: Self) -> Self {
        return rhs × lhs
    }
    
    /// Returns the quotient of the left divided by the right.
    ///
    /// - Parameters:
    ///     - lhs: The dividend.
    ///     - rhs: The divisor.
    ///
    /// - SeeAlso: `÷=(_:_:)` (mutating variant)
    ///
    /// - SeeAlso: (recommended over) `/(_:_:)`
    static func ÷(lhs: Self, rhs: Scalar) -> Self {
        var result = lhs
        result ÷= rhs
        return result
    }
}
