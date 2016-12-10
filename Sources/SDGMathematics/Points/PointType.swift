// PointType.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

/// A type that can be used with `+(_:_:)` and `−(_:_:)` in conjunction with an associated `Vector` type.
///
/// - Note: Unlike `Strideable`, `PointType`s do not need to conform to `Comparable`, allowing conformance by two‐dimensional points, etc.
///
/// Conformance Requirements:
///
/// - `Equatable`
/// - `static func +=(lhs: inout Self, rhs: Addend)`
/// - `static func −(lhs: Self, rhs: Self) -> Vector`
public protocol PointType: Equatable {

    /// The type to be used as a vector.
    associatedtype Vector: Negatable
    
    /// Returns the point arrived at by starting at the point on the left and moving according to the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to add.
    ///
    /// - SeeAlso: `+=(_:_:)` (mutating variant)
    static func +(lhs: Self, rhs: Vector) -> Self
    
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - SeeAlso: `+(_:_:)` (non‐mutating variant)
    static func +=(lhs: inout Self, rhs: Vector)
    
    /// Returns the point arrived at by starting at the point on the left and moving according to the inverse of the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    //static func −(lhs: Self, rhs: Vector) -> Self
    // !!!!!BUG!!!!! The above line is temporarily (Swift 3.0.1) commented because it falsely triggers “ambiguous use of operator” errors (see testSubtractable). This can be used again when the bug is fixed.
    
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    static func −(lhs: Self, rhs: Self) -> Vector
    
    /// Moves the point on the left by the inverse of the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to subtract.
    ///
    /// - SeeAlso: `−(_:_:)` (non‐mutating variant)
    static func −=(lhs: inout Self, rhs: Vector)
}

extension PointType  {

    fileprivate static func addAsPointType(_ lhs: Self, _ rhs: Vector) -> Self {
        var result = lhs
        result += rhs
        return result
    }
    /// Returns the point arrived at by starting at the point on the left and moving according to the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to add.
    ///
    /// - SeeAlso: `+=(_:_:)` (mutating variant)
    public static func +(lhs: Self, rhs: Vector) -> Self {
        return addAsPointType(lhs, rhs)
    }
    
    fileprivate static func subtractAsPointType(_ lhs: Self, _ rhs: Vector) -> Self {
        var result = lhs
        result −= rhs
        return result
    }
    /// Returns the point arrived at by starting at the point on the left and moving according to the inverse of the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    public static func −(lhs: Self, rhs: Vector) -> Self {
        return subtractAsPointType(lhs, rhs)
    }
    
    /// Moves the point on the left by the inverse of the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to subtract.
    ///
    /// - SeeAlso: `−(_:_:)` (non‐mutating variant)
    public static func −=(lhs: inout Self, rhs: Vector) {
        lhs += −rhs
    }
}

extension PointType where Self.Vector == Self {
    // MARK: - Self.Vector == Self
    
    /// Returns the point arrived at by starting at the point on the left and moving according to the inverse of the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to subtract.
    ///
    /// - SeeAlso: `−=(_:_:)` (mutating variant)
    public static func −(lhs: Self, rhs: Vector) -> Self {
        // Disambiguate Self − Vector = Self vs Self − Self = Vector
        return subtractAsPointType(lhs, rhs)
    }
}

extension PointType where Self : IntXType, Self.Vector == Self.Stride {
    // MARK: - where Self : IntXType, Vector == Stride
    
    /// Returns the point arrived at by starting at the point on the left and moving according to the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to add.
    ///
    /// - SeeAlso: `+=(_:_:)` (mutating variant)
    public static func +(lhs: Self, rhs: Stride) -> Self {
        return lhs.advanced(by: rhs)
    }
    
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - SeeAlso: `+(_:_:)` (non‐mutating variant)
    public static func +=(lhs: inout Self, rhs: Stride) {
        lhs = lhs.advanced(by: rhs)
    }
    
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    public static func −(lhs: Self, rhs: Self) -> Stride {
        return rhs.distance(to: lhs)
    }
}

extension PointType where Self : Strideable, Self.Vector == Self.Stride {
    // MARK: - where Self : Strideable, Vector == Stride
    
    /// Returns the point arrived at by starting at the point on the left and moving according to the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to add.
    ///
    /// - SeeAlso: `+=(_:_:)` (mutating variant)
    public static func +(lhs: Self, rhs: Vector) -> Self {
        // Disambiguate PointType.+ vs Strideable.+
        return addAsPointType(lhs, rhs)
    }
}

extension PointType where Self : UIntType, Self.Vector == Self.Stride {
    // MARK: - where Self : UIntType, Vector == Stride
    
    /// Returns the point arrived at by starting at the point on the left and moving according to the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The starting point.
    ///     - rhs: The vector to add.
    ///
    /// - SeeAlso: `+=(_:_:)` (mutating variant)
    public static func +(lhs: Self, rhs: Stride) -> Self {
        return lhs.advanced(by: rhs)
    }
    
    /// Moves the point on the left by the vector on the right.
    ///
    /// - Parameters:
    ///     - lhs: The point to modify.
    ///     - rhs: The vector to add.
    ///
    /// - SeeAlso: `+(_:_:)` (non‐mutating variant)
    public static func +=(lhs: inout Self, rhs: Stride) {
        lhs = lhs.advanced(by: rhs)
    }
    
    /// Returns the vector that leads from the point on the left to the point on the right.
    ///
    /// - Parameters:
    ///     - lhs: The endpoint.
    ///     - rhs: The startpoint.
    public static func −(lhs: Self, rhs: Self) -> Stride {
        return rhs.distance(to: lhs)
    }
}
