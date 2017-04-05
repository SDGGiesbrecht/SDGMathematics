/*
 Int.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A type that represents a fixed‐length integer.
///
/// This protocol exists so that extensions to it can provide shared functionality for `Int`, `Int64`, `Int32`, `Int16` and `Int8`.
public protocol IntType : Addable, AdditiveArithmetic, CustomPlaygroundQuickLookable, CustomReflectable, CVarArg, IntegerType, IntegralArithmetic, MirrorPath, Negatable, NumericAdditiveArithmetic, OneDimensionalPoint, PointType, SignedInteger, Subtractable, WholeArithmetic {

}

/// A type that represents a fixed‐length integer.
///
/// This protocol exists so that extensions to it can provide shared functionality for `Int64`, `Int32`, `Int16` and `Int8`.
public protocol IntXType : IntType {

}

extension Int : IntType {

    // MARK: - PointType

    /// The vector type.
    public typealias Vector = Stride
}

extension Int64 : IntXType {

    // MARK: - PointType

    /// The vector type.
    public typealias Vector = Stride

    // MARK: - WholeArithmetic

    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<Int64>, fromRandomizer randomizer: Randomizer) {

        if range.lowerBound.isWhole {
            let unsignedRange: ClosedRange<UInt64> = UInt64(range.lowerBound) ... UInt64(range.upperBound)
            let unsigned = UInt64(randomInRange: unsignedRange)
            self = Int64(unsigned)
        } else {
            let span = range.upperBound − range.lowerBound
            let unsignedRange: ClosedRange<UInt64> = 0 ... UInt64(span)
            let unsigned = UInt64(randomInRange: unsignedRange)
            self = range.lowerBound + Int64(unsigned)
        }
    }

}

extension Int32 : IntXType {

    // MARK: - PointType

    /// The vector type.
    public typealias Vector = Stride

}

extension Int16 : IntXType {

    // MARK: - PointType

    /// The vector type.
    public typealias Vector = Stride

}

extension Int8 : IntXType {

    // MARK: - PointType

    /// The vector type.
    public typealias Vector = Stride

}
