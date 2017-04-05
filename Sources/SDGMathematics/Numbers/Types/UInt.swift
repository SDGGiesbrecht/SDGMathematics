/*
 UInt.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A type that represents a fixed‐length unsigned integer.
///
/// This protocol exists so that extensions to it can provide shared functionality for `UInt`, `UInt64`, `UInt32`, `UInt16` and `UInt8`.
public protocol UIntType : Addable, AdditiveArithmetic, CustomPlaygroundQuickLookable, CustomReflectable, CVarArg, NumericAdditiveArithmetic, OneDimensionalPoint, PointType, Subtractable, UnsignedInteger, WholeArithmetic, WholeNumberType {

}

extension UInt : UIntType {

    // MARK: - PointType

    // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}

extension UInt64 : UIntType {

    // MARK: - PointType

    // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - WholeArithmetic

    // [_Inherit Documentation: SDGMathematics.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<UInt64>, fromRandomizer randomizer: Randomizer) {
        self = randomizer.randomNumber(inRange: range)
    }
}

extension UInt32 : UIntType {

    // MARK: - PointType

    // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}

extension UInt16 : UIntType {

    // MARK: - PointType

    // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

}

extension UInt8 : UIntType {

    // MARK: - PointType

    // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

}
