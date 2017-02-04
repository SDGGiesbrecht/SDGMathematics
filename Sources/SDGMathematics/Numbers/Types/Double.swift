/*
 Double.swift

 This source file is part of the SDGMathematics open source project.

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// swiftlint:disable disjunction
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
// swiftlint:enable disjunction
    
    import Foundation
    import CoreGraphics
#endif

import SDGLogic

/// A type that represents an floating‐point number.
///
/// This protocol exists so that extensions to it can provide shared functionality for `Double`, `Float80` and `Float`.
public protocol FloatType: Addable, AdditiveArithmetic, BinaryFloatingPoint, CustomDebugStringConvertible, IntegralArithmetic, Hashable, LosslessStringConvertible, Negatable, NumericAdditiveArithmetic, OneDimensionalPoint, PointType, RationalArithmetic, RealNumberType, Subtractable, WholeArithmetic {
    
    /// Creates a new value, rounded to the closest possible representation.
    ///
    /// - Parameters:
    ///     - value: The number to convert to a floating‐point value.
    init(_ value: Exponent)
    
    /// The value of ln(2).
    static var ln2: Self { get }
}

extension Double: FloatType {
    
    // MARK: - FloatType
    
    // swiftlint:disable hyphen_minus
    /// An instance of ln(2).
    public static let ln2: Double = 0x1.62E42FEFA39EFp-1
    // swiftlint:enable hyphen_minus
    
    // MARK: - PointType
    
    /// The vector type.
    public typealias Vector = Stride
    
    // MARK: - RealArithmetic
    
    /// An instance of *e*.
    public static let e: Double = 0x1.5BF0A8B145769p1
}

// swiftlint:disable disjunction
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
// swiftlint:enable disjunction
    extension CGFloat: FloatType {
        
        // MARK: - CustomDebugStringConvertible
        
        /// A textual representation of this instance, suitable for debugging.
        public var debugDescription: String {
            return NativeType(self).debugDescription
        }
        
        // MARK: - FloatType
        
        /// An instance of ln(2).
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
        
        /// The vector type.
        public typealias Vector = Stride
        
        // MARK: - RealArithmetic
        
        /// An instance of *e*.
        public static let e: CGFloat = CGFloat(Double.e)
    }
#endif

#if os(macOS) || os(Linux)
extension Float80: FloatType {
    
    // MARK: - FloatType
    
    // swiftlint:disable hyphen_minus
    /// An instance of ln(2).
    public static let ln2: Float80 = 0x1.62E42FEFA39EF358p-1
    // swiftlint:enable hyphen_minus
    
    // MARK: - PointType
    
    /// The vector type.
    public typealias Vector = Stride
    
    // MARK: - RealArithmetic
    
    /// An instance of *e*.
    public static let e: Float80 = 0x1.5BF0A8B145769535p1
}
#endif

extension Float: FloatType {
    
    // MARK: - FloatType
    
    // swiftlint:disable hyphen_minus
    /// An instance of ln(2).
    public static let ln2: Float = 0x1.62E430p-1
    // swiftlint:enable hyphen_minus
    
    // MARK: - PointType
    
    /// The vector type.
    public typealias Vector = Stride
    
    // MARK: - RealArithmetic
    
    /// An instance of *e*.
    public static let e: Float = 0x1.5BF0A9p1
}
