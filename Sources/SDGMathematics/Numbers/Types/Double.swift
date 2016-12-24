// Double.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

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
