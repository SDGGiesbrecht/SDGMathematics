/*
 IntegralArithmetic.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that can be used for integral arithmetic.
///
/// Conformance Requirements:
///
/// - `WholeArithmetic`
/// - `Negatable`
/// - `init(_ int: IntMax)`
public protocol IntegralArithmetic : AbsoluteValuable /* requires negatability */, Negatable, SignedNumber, WholeArithmetic {

    // [_Define Documentation: SDGMathematics.IntegralArithmetic.init(int:)_]
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of `IntMax`.
    init(_ int: IntMax)
}

extension IntegralArithmetic {

    // [_Define Documentation: SDGMathematics.IntegralArithmetic.init(intType:)_]
    /// Creates an instance equal to `int`.
    ///
    /// - Properties:
    ///     - int: An instance of a type conforming to `IntType`.
    public init<I : IntType>(_ int: I) {
        self.init(int.toIntMax())
    }
}
