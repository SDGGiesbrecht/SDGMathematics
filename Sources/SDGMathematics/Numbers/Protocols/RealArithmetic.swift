/*
 RealArithmetic.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

// [_Inherit Documentation: SDGMathematics.RealArithmetic.√_]
/// Returns the sequare root of `operand`.
///
/// - Parameters:
///     - operand: The radicand.
///
/// - MutatingVariant: √=
prefix operator √

// [_Inherit Documentation: SDGMathematics.RealArithmetic.√=_]
/// Sets `operand` to its square root.
///
/// - Parameters:
///     - operand: The value to modify.
///
/// - NonmutatingVariant: √
postfix operator √=

/// A type that can be used for real arithmetic.
///
/// Conformance Requirements:
///
/// - `RationalArithmetic`
/// - `static var π: Self { get }`
/// - `static var e: Self { get }`
/// - `mutating func formLogarithm(toBase base: Self)`
/// - `static func sin(_ angle: Angle<Self>) -> Self`
/// - `static func arctan(_ tangent: Self) -> Angle<Self>`
public protocol RealArithmetic : RationalArithmetic {

    // MARK: - Constants

    // [_Define Documentation: SDGMathematics.RealArithmetic.π_]
    /// An instance of π.
    static var π: Self { get }

    // [_Define Documentation: SDGMathematics.RealArithmetic.τ_]
    /// An instance of τ.
    static var τ: Self { get }

    // [_Define Documentation: SDGMathematics.RealArithmetic.e_]
    /// An instance of *e*.
    static var e: Self { get }

    // MARK: - Operations

    // [_Define Documentation: SDGMathematics.RealArithmetic.root(ofDegree:)_]
    /// Returns the `degree`‐th root of `self`.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    ///
    /// - MutatingVariant: formRoot
    func root(ofDegree degree: Self) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.formRoot(ofDegree:)_]
    /// Sets `self` to its `degree`‐th root.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    ///
    /// - NonmutatingVariant: root
    mutating func formRoot(ofDegree degree: Self)

    // [_Define Documentation: SDGMathematics.RealArithmetic.√_]
    /// Returns the sequare root of `operand`.
    ///
    /// - Parameters:
    ///     - operand: The radicand.
    ///
    /// - MutatingVariant: √=
    static prefix func √ (operand: Self) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.√=_]
    /// Sets `operand` to its square root.
    ///
    /// - Parameters:
    ///     - operand: The value to modify.
    ///
    /// - NonmutatingVariant: √
    static postfix func √= (operand: inout Self)

    // [_Define Documentation: SDGMathematics.RealArithmetic.log(toBase:of:)_]
    /// Returns the base `base` logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Precondition: `base` > 0
    ///
    /// - Precondition: `base` ≠ 1
    ///
    /// - Parameters:
    ///     - base: The base.
    ///     - antilogarithm: The antilogarithm.
    ///
    /// - MutatingVariant: formLogarithm
    static func log(toBase base: Self, of antilogarithm: Self) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.formLogarithm(toBase:)_]
    /// Sets `self` to its base `base` logarithm.
    ///
    /// - Precondition: `self` > 0
    ///
    /// - Precondition: `base` > 0
    ///
    /// - Precondition: `base` ≠ 1
    ///
    /// - Parameters:
    ///     - base: The base.
    ///
    /// - NonmutatingVariant: log
    mutating func formLogarithm(toBase base: Self)

    // [_Define Documentation: SDGMathematics.RealArithmetic.log(_:)_]
    /// Returns the common logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    ///
    /// - MutatingVariant: formCommonLogarithm
    static func log(_ antilogarithm: Self) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.formCommonLogarithm()_]
    /// Sets `self` to its common logarithm.
    ///
    /// - Precondition: `self` > 0
    ///
    /// - NonmutatingVariant: log
    mutating func formCommonLogarithm()

    // [_Define Documentation: SDGMathematics.RealArithmetic.ln(_:)_]
    /// Returns the natural logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    ///
    /// - MutatingVariant: formNaturalLogarithm
    static func ln(_ antilogarithm: Self) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.formNaturalLogarithm()_]
    /// Sets `self` to its natural logarithm.
    ///
    /// - Precondition: `self` > 0
    ///
    /// - NonmutatingVariant: ln
    mutating func formNaturalLogarithm()

    // [_Define Documentation: SDGMathematics.RealArithmetic.sin(_:)_]
    /// Returns the sine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func sin(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.cos(_:)_]
    /// Returns the cosine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func cos(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.tan(_:)_]
    /// Returns the tangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func tan(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.csc(_:)_]
    /// Returns the cosecant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func csc(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.sec(_:)_]
    /// Returns the secant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func sec(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.cot(_:)_]
    /// Returns the cotangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    static func cot(_ angle: Angle<Self>) -> Self

    // [_Define Documentation: SDGMathematics.RealArithmetic.arcsin(_:)_]
    /// Returns the arcsine of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - sine: The sine.
    static func arcsin(_ sine: Self) -> Angle<Self>

    // [_Define Documentation: SDGMathematics.RealArithmetic.arccos(_:)_]
    /// Returns the arccosine of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - cosine: The cosine.
    static func arccos(_ cosine: Self) -> Angle<Self>

    // [_Define Documentation: SDGMathematics.RealArithmetic.arctan(_:)_]
    /// Returns the arctangent of a value.
    ///
    /// The returned angle will be between −90° and 90°.
    ///
    /// - Parameters:
    ///     - tangent: The tangent.
    static func arctan(_ tangent: Self) -> Angle<Self>

    // [_Define Documentation: SDGMathematics.RealArithmetic.arccsc(_:)_]
    /// Returns the arccosecant of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive, but never 0°.
    ///
    /// - Precondition: −1 ≥ `cosecant` ∨ `cosecant` ≤ 1
    ///
    /// - Parameters:
    ///     - cosecant: The cosecant.
    static func arccsc(_ cosecant: Self) -> Angle<Self>

    // [_Define Documentation: SDGMathematics.RealArithmetic.arcsec(_:)_]
    /// Returns the arcsecant of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive, but never 90°.
    ///
    /// - Precondition: −1≥ `secant` ∨ `secant` ≤ 1
    ///
    /// - Parameters:
    ///     - secant: The secant.
    static func arcsec(_ secant: Self) -> Angle<Self>

    // [_Define Documentation: SDGMathematics.RealArithmetic.arccot(_:)_]
    /// Returns the arccotangent of a value.
    ///
    /// The returned angle will be between 0° and 180°.
    ///
    /// - Parameters:
    ///     - cotangent: The cotangent.
    static func arccot(_ cotangent: Self) -> Angle<Self>
}

// MARK: - Real Arithmetic

/// An instance of π in the desired return type.
///
/// - Note: This is an alias for `N.π` to improve the legibility of code involving mathematical equations.
public func π<N : RealArithmetic>() -> N {
    return N.π
}

/// An instance of τ in the desired return type.
///
/// - Note: This is an alias for `N.τ` to improve the legibility of code involving mathematical equations.
public func τ<N : RealArithmetic>() -> N {
    return N.τ
}

/// An instance of *e* in the desired return type.
///
/// - Note: This is an alias for `N.e` to improve the legibility of code involving mathematical equations.
public func e<N : RealArithmetic>() -> N {
    return N.e
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.log(toBase:of:)_]
/// Returns the base `base` logarithm of `antilogarithm`.
///
/// - Precondition: `antilogarithm` > 0
///
/// - Precondition: `base` > 0
///
/// - Precondition: `base` ≠ 1
///
/// - Parameters:
///     - base: The base.
///     - antilogarithm: The antilogarithm.
///
/// - MutatingVariant: formLogarithm
public func log<N : RealArithmetic>(toBase base: N, of antilogarithm: N) -> N {
    return N.log(toBase: base, of: antilogarithm)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.log(_:)_]
/// Returns the common logarithm of `antilogarithm`.
///
/// - Precondition: `antilogarithm` > 0
///
/// - Parameters:
///     - antilogarithm: The antilogarithm.
///
/// - MutatingVariant: formCommonLogarithm
public func log<N : RealArithmetic>(_ antilogarithm: N) -> N {
    return N.log(antilogarithm)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.ln(_:)_]
/// Returns the natural logarithm of `antilogarithm`.
///
/// - Precondition: `antilogarithm` > 0
///
/// - Parameters:
///     - antilogarithm: The antilogarithm.
///
/// - MutatingVariant: formNaturalLogarithm
public func ln<N : RealArithmetic>(_ antilogarithm: N) -> N {
    return N.ln(antilogarithm)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.sin(_:)_]
/// Returns the sine of an angle.
///
/// - Parameters:
///     - angle: The angle.
public func sin<N : RealArithmetic>(_ angle: Angle<N>) -> N {
    return N.sin(angle)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.cos(_:)_]
/// Returns the cosine of an angle.
///
/// - Parameters:
///     - angle: The angle.
public func cos<N : RealArithmetic>(_ angle: Angle<N>) -> N {
    return N.cos(angle)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.tan(_:)_]
/// Returns the tangent of an angle.
///
/// - Parameters:
///     - angle: The angle.
public func tan<N : RealArithmetic>(_ angle: Angle<N>) -> N {
    return N.tan(angle)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.csc(_:)_]
/// Returns the cosecant of an angle.
///
/// - Parameters:
///     - angle: The angle.
public func csc<N : RealArithmetic>(_ angle: Angle<N>) -> N {
    return N.csc(angle)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.sec(_:)_]
/// Returns the secant of an angle.
///
/// - Parameters:
///     - angle: The angle.
public func sec<N : RealArithmetic>(_ angle: Angle<N>) -> N {
    return N.sec(angle)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.cot(_:)_]
/// Returns the cotangent of an angle.
///
/// - Parameters:
///     - angle: The angle.
public func cot<N : RealArithmetic>(_ angle: Angle<N>) -> N {
    return N.cot(angle)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.arcsin(_:)_]
/// Returns the arcsine of a value.
///
/// The returned angle will be between −90° and 90° inclusive.
///
/// - Precondition: −1 ≤ `sine` ≤ 1
///
/// - Parameters:
///     - sine: The sine.
public func arcsin<N : RealArithmetic>(_ sine: N) -> Angle<N> {
    return N.arcsin(sine)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.arccos(_:)_]
/// Returns the arccosine of a value.
///
/// The returned angle will be between 0° and 180° inclusive.
///
/// - Precondition: −1 ≤ `sine` ≤ 1
///
/// - Parameters:
///     - cosine: The cosine.
public func arccos<N : RealArithmetic>(_ cosine: N) -> Angle<N> {
    return N.arccos(cosine)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.arctan(_:)_]
/// Returns the arctangent of a value.
///
/// The returned angle will be between −90° and 90°.
///
/// - Parameters:
///     - tangent: The tangent.
public func arctan<N : RealArithmetic>(_ tangent: N) -> Angle<N> {
    return N.arctan(tangent)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.arccsc(_:)_]
/// Returns the arccosecant of a value.
///
/// The returned angle will be between −90° and 90° inclusive, but never 0°.
///
/// - Precondition: −1 ≥ `cosecant` ∨ `cosecant` ≤ 1
///
/// - Parameters:
///     - cosecant: The cosecant.
public func arccsc<N : RealArithmetic>(_ cosecant: N) -> Angle<N> {
    return N.arccsc(cosecant)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.arcsec(_:)_]
/// Returns the arcsecant of a value.
///
/// The returned angle will be between 0° and 180° inclusive, but never 90°.
///
/// - Precondition: −1≥ `secant` ∨ `secant` ≤ 1
///
/// - Parameters:
///     - secant: The secant.
public func arcsec<N : RealArithmetic>(_ secant: N) -> Angle<N> {
    return N.arcsec(secant)
}

// [_Inherit Documentation: SDGMathematics.RealArithmetic.arctan(_:)_]
/// Returns the arctangent of a value.
///
/// The returned angle will be between −90° and 90°.
///
/// - Parameters:
///     - tangent: The tangent.
public func arccot<N : RealArithmetic>(_ cotangent: N) -> Angle<N> {
    return N.arccot(cotangent)
}

extension RealArithmetic {

    /// π in the same type.
    ///
    /// - Note: This is an alias for `Self.π` to improve the legibility of code involving mathematical equations.
    public var π: Self {
        return Self.π
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.τ_]
    /// An instance of τ.
    public static var τ: Self {
        return 2 × π
    }

    /// τ in the same type.
    ///
    /// - Note: This is an alias for `Self.τ` to improve the legibility of code involving mathematical equations.
    public var τ: Self {
        return Self.τ
    }

    /// *e* in the same type.
    ///
    /// - Note: This is an alias for `Self.e` to improve the legibility of code involving mathematical equations.
    public var e: Self {
        return Self.e
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.root(ofDegree:)_]
    /// Returns the `degree`‐th root of `self`.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    ///
    /// - MutatingVariant: formRoot
    public func root(ofDegree degree: Self) -> Self {
        var result = self
        result.formRoot(ofDegree: degree)
        return result
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.formRoot(ofDegree:)_]
    /// Sets `self` to its `degree`‐th root.
    ///
    /// - Parameters:
    ///     - degree: The degree of the root.
    ///
    /// - NonmutatingVariant: root
    public mutating func formRoot(ofDegree degree: Self) {
        self ↑= (1 ÷ degree)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.√_]
    /// Returns the sequare root of `operand`.
    ///
    /// - Parameters:
    ///     - operand: The radicand.
    ///
    /// - MutatingVariant: √=
    public static prefix func √ (operand: Self) -> Self {
        var result = operand
        result√=
        return result
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.√=_]
    /// Sets `operand` to its square root.
    ///
    /// - Parameters:
    ///     - operand: The value to modify.
    ///
    /// - NonmutatingVariant: √
    public static postfix func √= (operand: inout Self) {
        operand.formRoot(ofDegree: 2)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.log(toBase:of:)_]
    /// Returns the base `base` logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Precondition: `base` > 0
    ///
    /// - Precondition: `base` ≠ 1
    ///
    /// - Parameters:
    ///     - base: The base.
    ///     - antilogarithm: The antilogarithm.
    ///
    /// - MutatingVariant: formLogarithm
    public static func log(toBase base: Self, of antilogarithm: Self) -> Self {
        var result = antilogarithm
        result.formLogarithm(toBase: base)
        return result
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.log(_:)_]
    /// Returns the common logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    ///
    /// - MutatingVariant: formCommonLogarithm
    public static func log(_ antilogarithm: Self) -> Self {
        var result = antilogarithm
        result.formCommonLogarithm()
        return result
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.formCommonLogarithm()_]
    /// Sets `self` to its common logarithm.
    ///
    /// - Precondition: `self` > 0
    ///
    /// - NonmutatingVariant: log
    public mutating func formCommonLogarithm() {
        formLogarithm(toBase: 10)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.ln(_:)_]
    /// Returns the natural logarithm of `antilogarithm`.
    ///
    /// - Precondition: `antilogarithm` > 0
    ///
    /// - Parameters:
    ///     - antilogarithm: The antilogarithm.
    ///
    /// - MutatingVariant: formNaturalLogarithm
    public static func ln(_ antilogarithm: Self) -> Self {
        var result = antilogarithm
        result.formNaturalLogarithm()
        return result
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.formNaturalLogarithm()_]
    /// Sets `self` to its natural logarithm.
    ///
    /// - Precondition: `self` > 0
    ///
    /// - NonmutatingVariant: ln
    public mutating func formNaturalLogarithm() {
        formLogarithm(toBase: e)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.cos(_:)_]
    /// Returns the cosine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    public static func cos(_ angle: Angle<Self>) -> Self {
        return sin(angle + (π ÷ 2).rad)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.tan(_:)_]
    /// Returns the tangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    public static func tan(_ angle: Angle<Self>) -> Self {
        return sin(angle) ÷ cos(angle)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.csc(_:)_]
    /// Returns the cosecant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    public static func csc(_ angle: Angle<Self>) -> Self {
        return 1 ÷ sin(angle)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.sec(_:)_]
    /// Returns the secant of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    public static func sec(_ angle: Angle<Self>) -> Self {
        return 1 ÷ cos(angle)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.cot(_:)_]
    /// Returns the cotangent of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    public static func cot(_ angle: Angle<Self>) -> Self {
        return 1 ÷ tan(angle)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.arcsin(_:)_]
    /// Returns the arcsine of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - sine: The sine.
    public static func arcsin(_ sine: Self) -> Angle<Self> {
        assert((−1 ... 1).contains(sine), "There is no arcsine angle for any number x, where |x| > 1. In this case, the number \(sine).")
        return arctan(sine ÷ √(1 − sine ↑ 2))
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.arccos(_:)_]
    /// Returns the arccosine of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive.
    ///
    /// - Precondition: −1 ≤ `sine` ≤ 1
    ///
    /// - Parameters:
    ///     - cosine: The cosine.
    public static func arccos(_ cosine: Self) -> Angle<Self> {
        assert((−1 ... 1).contains(cosine), "There is no arccosine angle for any number x, where |x| > 1. In this case, the number \(cosine).")
        return (π ÷ 2).rad − arcsin(cosine)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.arccsc(_:)_]
    /// Returns the arccosecant of a value.
    ///
    /// The returned angle will be between −90° and 90° inclusive, but never 0°.
    ///
    /// - Precondition: −1 ≥ `cosecant` ∨ `cosecant` ≤ 1
    ///
    /// - Parameters:
    ///     - cosecant: The cosecant.
    public static func arccsc(_ cosecant: Self) -> Angle<Self> {
        assert(¬(−1 ... 1).contains(cosecant), "There is no arccosecant angle for any number x, where |x| < 1. In this case, the number \(cosecant).")
        return arcsin(1 ÷ cosecant)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.arcsec(_:)_]
    /// Returns the arcsecant of a value.
    ///
    /// The returned angle will be between 0° and 180° inclusive, but never 90°.
    ///
    /// - Precondition: −1≥ `secant` ∨ `secant` ≤ 1
    ///
    /// - Parameters:
    ///     - secant: The secant.
    public static func arcsec(_ secant: Self) -> Angle<Self> {
        assert(¬(−1 ... 1).contains(secant), "There is no arccosecant angle for any number x, where |x| < 1. In this case, the number \(secant).")
        return arccos(1 ÷ secant)
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.arccot(_:)_]
    /// Returns the arccotangent of a value.
    ///
    /// The returned angle will be between 0° and 180°.
    ///
    /// - Parameters:
    ///     - cotangent: The cotangent.
    public static func arccot(_ cotangent: Self) -> Angle<Self> {
        let reference = arctan(1 ÷ cotangent)
        if reference < Angle.additiveIdentity {
            return reference + π.rad
        } else {
            return reference
        }
    }

    // MARK: - Angles

    // [_Define Documentation: SDGMathematics.RealArithmetic.radians_]
    /// Returns an angle in radians.
    public var radians: Angle<Self> {
        return Angle(radians: self)
    }
    // [_Inherit Documentation: SDGMathematics.RealArithmetic.radians_]
    /// Returns an angle in radians.
    public var rad: Angle<Self> {
        return radians
    }

    // [_Define Documentation: SDGMathematics.RealArithmetic.rotations_]
    /// Returns an angle in rotations.
    public var rotations: Angle<Self> {
        return Angle(rotations: self)
    }

    // [_Define Documentation: SDGMathematics.RealArithmetic.degrees_]
    /// Returns an angle in degrees.
    public var degrees: Angle<Self> {
        return Angle(degrees: self)
    }

    // [_Define Documentation: SDGMathematics.RealArithmetic.minutes_]
    /// Returns an angle in minutes.
    public var minutes: Angle<Self> {
        return Angle(minutes: self)
    }

    // [_Define Documentation: SDGMathematics.RealArithmetic.seconds_]
    /// Returns an angle in seconds.
    public var seconds: Angle<Self> {
        return Angle(seconds: self)
    }

    // [_Define Documentation: SDGMathematics.RealArithmetic.gradians_]
    /// Returns an angle in gradians.
    public var gradians: Angle<Self> {
        return Angle(gradians: self)
    }
}

extension RealArithmetic where Self : FloatType {
    // MARK: - where Self : FloatType

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.π_]
    /// An instance of π.
    public static var π: Self {
        return pi
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.√_]
    /// Returns the sequare root of `operand`.
    ///
    /// - Parameters:
    ///     - operand: The radicand.
    ///
    /// - MutatingVariant: √=
    public static prefix func √ (operand: Self) -> Self {
        return operand.squareRoot()
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.√=_]
    /// Sets `operand` to its square root.
    ///
    /// - Parameters:
    ///     - operand: The value to modify.
    ///
    /// - NonmutatingVariant: √
    public static postfix func √= (operand: inout Self) {
        operand = operand.squareRoot()
    }

    private mutating func tryConvenientLogarithms(toBase base: Self) -> Bool {

        assert(self > 0, "Logarithms of non‐positive numbers are undefined. (In this case, the logarithm of \(self).)")
        assert(base > 0, "Logarithms in a non‐positive base are undefined. (In this case, the base \(base) logarithm.")
        assert(base ≠ 1, "Logarithms in base 1 are undefined.")

        if self == 1 {
            self = 0 // x ↑ 0 = 1
            return true
        } else if self == base {
            self = 1 // x ↑ 1 = x
            return true
        } else {
            // not convenient
            return false
        }
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.formLogarithm(toBase:)_]
    /// Sets `self` to its base `base` logarithm.
    ///
    /// - Precondition: `self` > 0
    ///
    /// - Precondition: `base` > 0
    ///
    /// - Precondition: `base` ≠ 1
    ///
    /// - Parameters:
    ///     - base: The base.
    ///
    /// - NonmutatingVariant: log
    public mutating func formLogarithm(toBase base: Self) {

        if ¬tryConvenientLogarithms(toBase: base) {

            // log (a) = log (a) ÷ log (b)
            //    b         x         x

            formNaturalLogarithm()
            self ÷= ln(base)
        }
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.formNaturalLogarithm()_]
    /// Sets `self` to its natural logarithm.
    ///
    /// - Precondition: `self` > 0
    ///
    /// - NonmutatingVariant: ln
    public mutating func formNaturalLogarithm() {

        if ¬tryConvenientLogarithms(toBase: e) {

            if self == 2 {
                self = Self.ln2
            } else {
                // if y = s × b ↑ x
                // then ln(y) = ln(s) + x × ln(b)

                let s: Self = significand
                let x = Self(exponent)
                // Since 1 ≤ s < 2, (or possibly 0 ≤ s for subnormal values?)
                // s satisfies 0 ≤ s < 2 and the Taylor series around 1 will converge:
                //
                //   ∞         n + 1          n
                //   ∑    ( (−1)      _(s_−_1)__ )
                // n = 1                  n

                self = 0
                var lastApproximate = self
                var n: Self = 1
                var negative = false
                let sMinusOne: Self = s − 1
                var numerator: Self = sMinusOne
                repeat {
                    lastApproximate = self

                    var term = numerator ÷ n
                    if negative {
                        term−=
                    }
                    self += term

                    n += 1
                    negative¬=
                    numerator ×= sMinusOne

                } while self ≠ lastApproximate

                self += x × Self.ln2
            }
        }
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.sin(_:)_]
    /// Returns the sine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    public static func sin(_ angle: Angle<Self>) -> Self {

        if ¬(additiveIdentity.rad ..< τ.rad).contains(angle) {
            // Use periodic reference angle.
            return sin(angle.mod(τ.rad))
        } else if angle > π.rad {
            // Quadrants III & IV
            return −sin(angle − π.rad)
        } else if angle > (π ÷ 2).rad {
            // Quadrant II
            return sin(π.rad − angle)
        } else {
            // Quadrant I

            if angle > (π ÷ 4).rad {
                // Cosine converges faster in this range.
                return cos((π ÷ 2).rad − angle)
            } else {

                //   ∞         n + 1     2n − 1
                //   ∑    ( (−1)      __θ________ )
                // n = 1               (2n − 1)!

                var result: Self = 0
                var lastApproximate: Self = result
                var negative = false
                var numerator = angle.inRadians
                var _2n_m_1: Self = 1
                var denominator: Self = 1
                repeat {
                    lastApproximate = result

                    var term = numerator ÷ denominator
                    if negative {
                        term−=
                    }
                    result += term

                    negative¬=

                    let multiplicationStep = {
                        numerator ×= angle.inRadians
                        _2n_m_1 += 1
                        denominator ×= _2n_m_1
                    }
                    multiplicationStep()
                    multiplicationStep()

                } while result ≠ lastApproximate

                return result
            }
        }
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.cos(_:)_]
    /// Returns the cosine of an angle.
    ///
    /// - Parameters:
    ///     - angle: The angle.
    public static func cos(_ angle: Angle<Self>) -> Self {

        if ¬(additiveIdentity.rad ..< τ.rad).contains(angle) {
            // Use periodic reference angle.
            return cos(angle.mod(τ.rad))
        } else if angle > π.rad {
            // Quadrants III & IV
            return cos(τ.rad − angle)
        } else if angle > (π ÷ 2).rad {
            // Quadrant II
            return −cos(π.rad − angle)
        } else {
            // Quadrant I

            if angle > (π ÷ 4).rad {
                // Sine converges faster in this range.
                return sin((π ÷ 2).rad − angle)
            } else {

                //   ∞         n + 1      2n
                //   ∑    ( (−1)      ___θ___ )
                // n = 0               (2n)!

                var result: Self = 0
                var lastApproximate: Self = result
                var negative = false
                var numerator: Self = 1
                var _2n: Self = 0
                var denominator: Self = 1
                repeat {
                    lastApproximate = result

                    var term = numerator ÷ denominator
                    if negative {
                        term−=
                    }
                    result += term

                    negative¬=

                    let multiplicationStep = {
                        numerator ×= angle.inRadians
                        _2n += 1
                        denominator ×= _2n
                    }
                    multiplicationStep()
                    multiplicationStep()

                } while result ≠ lastApproximate

                return result
            }
        }
    }

    // [_Inherit Documentation: SDGMathematics.RealArithmetic.arctan(_:)_]
    /// Returns the arctangent of a value.
    ///
    /// The returned angle will be between −90° and 90°.
    ///
    /// - Parameters:
    ///     - tangent: The tangent.
    public static func arctan(_ tangent: Self) -> Angle<Self> {

        if tangent.isNegative {
            return −arctan(−tangent)
        } else if tangent > 1 {
            return (π ÷ 2).rad − arctan(1 ÷ tangent)
        } else if tangent > 2 − √3 {
            let r3: Self = √3
            return (π ÷ 6).rad + arctan((r3 × tangent − 1) ÷ (r3 + tangent))
        } else {

            //   ∞         n + 1     2n − 1
            //   ∑    ( (−1)      __x_______ )
            // n = 1               (2n − 1)

            var result: Self = 0
            var lastApproximate: Self = result
            var negative = false
            var numerator = tangent
            let x_2 = tangent × tangent
            var denominator: Self = 1
            repeat {
                lastApproximate = result

                var term = numerator ÷ denominator
                if negative {
                    term−=
                }
                result += term

                negative¬=
                numerator ×= x_2
                denominator += 2

            } while result ≠ lastApproximate

            return result.radians
        }
    }
}
