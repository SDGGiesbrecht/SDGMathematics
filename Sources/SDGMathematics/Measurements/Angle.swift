// Angle.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

/// Creates a measurement in degrees.
postfix operator °

/// Creates a measurement in minutes, the absolute complement of a set, etc. Behaviour depends on the type.
postfix operator ′

/// Creates a measurement in seconds.
postfix operator ′′

// MARK: - Angles

/// Returns an angle in degrees.
///
/// - Parameters:
///     - value: The value in degrees.
public postfix func °<N: RealArithmetic>(value: N) -> Angle<N> {
    return value.degrees
}

/// Returns an angle in minutes.
///
/// - Parameters:
///     - value: The value in minutes.
public postfix func ′<N: RealArithmetic>(value: N) -> Angle<N> {
    return value.minutes
}

/// Returns an angle in seconds.
///
/// - Parameters:
///     - value: The value in seconds.
public postfix func ′′<N: RealArithmetic>(value: N) -> Angle<N> {
    return value.seconds
}

/// An angle.
public struct Angle<Value: RealArithmetic>: Measurement {
    
    // MARK: - Initialization
    
    /// Creates an angle in radians.
    public init(radians: Value) {
        self.inRadians = radians
    }
    
    /// Creates an angle in rotations.
    public init(rotations: Value) {
        self.init()
        inRotations = rotations
    }
    
    /// Creates an angle in degrees.
    public init(degrees: Value) {
        self.init()
        inDegrees = degrees
    }
    
    /// Creates an angle in minutes.
    public init(minutes: Value) {
        self.init()
        inMinutes = minutes
    }
    
    /// Creates an angle in seconds.
    public init(seconds: Value) {
        self.init()
        inSeconds = seconds
    }
    
    /// Creates an angle in gradians.
    public init(gradians: Value) {
        self.init()
        inGradians = gradians
    }
    
    // MARK: - Units
    
    /// The numeric value in radians.
    public var inRadians: Value
    
    private static var radiansPerRotation: Value {
        return Value.τ
    }
    /// The numeric value in rotations.
    public var inRotations: Value {
        get {
            return inRadians ÷ Angle.radiansPerRotation
        }
        set {
            inRadians = newValue × Angle.radiansPerRotation
        }
    }
    
    private static var radiansPerDegree: Value {
        return radiansPerRotation ÷ 360
    }
    /// The numeric value in degrees.
    public var inDegrees: Value {
        get {
            return inRadians ÷ Angle.radiansPerDegree
        }
        set {
            inRadians = newValue × Angle.radiansPerDegree
        }
    }
    
    private static var radiansPerMinute: Value {
        return radiansPerDegree ÷ 60
    }
    /// The numeric value in minutes.
    public var inMinutes: Value {
        get {
            return inRadians ÷ Angle.radiansPerMinute
        }
        set {
            inRadians = newValue × Angle.radiansPerMinute
        }
    }
    
    private static var radiansPerSecond: Value {
        return radiansPerMinute ÷ 60
    }
    /// The numeric value in seconds.
    public var inSeconds: Value {
        get {
            return inRadians ÷ Angle.radiansPerSecond
        }
        set {
            inRadians = newValue × Angle.radiansPerSecond
        }
    }
    
    private static var radiansPerGradian: Value {
        return radiansPerRotation ÷ 400
    }
    /// The numeric value in gradians.
    public var inGradians: Value {
        get {
            return inRadians ÷ Angle.radiansPerGradian
        }
        set {
            inRadians = newValue × Angle.radiansPerGradian
        }
    }
    
    // MARK: - Measurement
    
    /// The numeric type used to express the value in any given unit.
    public typealias Scalar = Value
    
    /// Creates a measurement from a raw value.
    public init(rawValue: Scalar) {
        inRadians = rawValue
    }
    
    /// A raw value.
    public var rawValue: Scalar {
        get {
            return inRadians
        }
        set {
            inRadians = newValue
        }
    }
}
