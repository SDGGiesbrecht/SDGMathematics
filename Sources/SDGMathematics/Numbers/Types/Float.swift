/*
 Float.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if os(Linux)
#else
    import CoreGraphics
#endif

import SDGLogic

#if os(macOS) || os(Linux)
    public typealias FloatMax = Float80
#else
    public typealias FloatMax = Double
#endif

/// A type that represents a floating‐point number.
///
/// This protocol exists so that extensions to it can provide shared functionality for `Double`, `Float80` and `Float`.
public protocol FloatType : Addable, AdditiveArithmetic, BinaryFloatingPoint, CustomDebugStringConvertible, IntegralArithmetic, Hashable, LosslessStringConvertible, Negatable, NumericAdditiveArithmetic, OneDimensionalPoint, PointType, RationalArithmetic, RealNumberType, Subtractable, WholeArithmetic {

    // [_Define Documentation: SDGMathematics.FloatType.init(_:)_]
    /// Creates a new value, rounded to the closest possible representation.
    ///
    /// - Parameters:
    ///     - value: The number to convert to a floating‐point value.
    init(_ value: Exponent)

    // [_Define Documentation: SDGMathematics.FloatType.ln2_]
    /// The value of ln2.
    static var ln2: Self { get }
}

extension Double : FloatType {

    // MARK: - FloatType

    // [_Inherit Documentation: SDGMathematics.FloatType.ln2_]
    /// The value of ln2.
    public static let ln2: Double = 0x1.62E42FEFA39EFp-1

    // MARK: - PointType

    // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - RealArithmetic

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.e_]
    /// An instance of *e*.
    public static let e: Double = 0x1.5BF0A8B145769p1
}

#if os(Linux) || LinuxDocs
#else

    extension CGFloat : FloatType {

        // MARK: - CustomDebugStringConvertible

        /// A textual representation of this instance, suitable for debugging.
        public var debugDescription: String {
            return NativeType(self).debugDescription
        }

        // MARK: - FloatType

        // [_Inherit Documentation: SDGMathematics.FloatType.ln2_]
        /// The value of ln2.
        public static let ln2: CGFloat = CGFloat(Double.ln2)

        // MARK: - LosslessStringConvertible

        /// Instantiates an instance of the conforming type from a string representation.
        ///
        /// - Parameters:
        ///     - description: The string representation.
        public init?(_ description: String) {
            if let result = NativeType(description) {
                self = CGFloat(result)
            } else {
                return nil
            }
        }

        // MARK: - PointType

        // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
        /// The type to be used as a vector.
        public typealias Vector = Stride

        // MARK: - RealArithmetic

        // [_Inherit Documentation: SDGMathematics.RealArithmetic.e_]
        /// An instance of *e*.
        public static let e: CGFloat = CGFloat(Double.e)
    }
#endif

#if os(macOS) || os(Linux)
    extension Float80 : FloatType {

        // MARK: - FloatType

        // [_Inherit Documentation: SDGMathematics.FloatType.ln2_]
        /// The value of ln2.
        public static let ln2: Float80 = 0x1.62E42FEFA39EF358p-1

        // MARK: - PointType

        // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
        /// The type to be used as a vector.
        public typealias Vector = Stride

        // MARK: - RealArithmetic

        // [_Inherit Documentation: SDGMathematics.RealArithmetic.e_]
        /// An instance of *e*.
        public static let e: Float80 = 0x1.5BF0A8B145769535p1
    }
#endif

extension Float : FloatType {

    // MARK: - FloatType

    // [_Inherit Documentation: SDGMathematics.FloatType.ln2_]
    /// The value of ln2.
    public static let ln2: Float = 0x1.62E430p-1

    // MARK: - PointType

    // [_Inherit Documentation: SDGMathematics.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

    // MARK: - RealArithmetic

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.e_]
    /// An instance of *e*.
    public static let e: Float = 0x1.5BF0A9p1
}
