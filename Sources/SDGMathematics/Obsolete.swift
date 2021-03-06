/*
 Obsolete.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// Version 1: 2017‐04‐04

infix operator √: ExponentPrecedence
infix operator √=: AssignmentPrecedence

extension RealArithmetic {

    @available(*, unavailable, message: "Use “rhs.root(ofDegree: lhs)” instead.")
    static func √ (lhs: Self, rhs: Self) -> Self {
        fatalError()
    }

    @available(*, unavailable, message: "Use “rhs.formRoot(ofDegree: lhs)” instead.")
    static func √= (lhs: inout Self, rhs: Self) {
        fatalError()
    }
}

@available(*, unavailable, message: "Use “AdditiveArithmetic.additiveIdentity” instead.")
public func _0<N : AdditiveArithmetic>() -> N {
    fatalError()
}

extension AdditiveArithmetic {

    @available(*, unavailable, renamed: "additiveIdentity")
    public static var _0: Self {
        fatalError()
    }

    @available(*, unavailable, message: "Use “Self.additiveIdentity” instead.")
    public var _0: Self {
        fatalError()
    }
}

infix operator ≤=: AssignmentPrecedence

extension Comparable {

    @available(*, unavailable, message: "Use “lhs.decrease(to: rhs)” instead.")
    public static func ≤= (lhs: inout Self, rhs: Self) {
        fatalError()
    }
}

infix operator ≥=: AssignmentPrecedence

extension Comparable {

    @available(*, unavailable, message: "Use “lhs.increase(to: rhs)” instead.")
    public static func ≥= (lhs: inout Self, rhs: Self) {
        fatalError()
    }
}

extension WholeArithmetic {

    @available(*, unavailable, renamed: "isNatural")
    public var isANaturalNumber: Bool {
        fatalError()
    }

    @available(*, unavailable, renamed: "isWhole")
    public var isAWholeNumber: Bool {
        fatalError()
    }

    @available(*, unavailable, renamed: "isIntegral")
    public var isAnInteger: Bool {
        fatalError()
    }
}

extension WholeArithmetic where Self : IntegerType {
    // MARK: - where Self : IntegerType

    @available(*, unavailable, renamed: "isIntegral")
    public var isAnInteger: Bool {
        fatalError()
    }
}

extension WholeArithmetic where Self : WholeNumberType {
    // MARK: - where Self : WholeNumberType

    @available(*, unavailable, renamed: "isWhole")
    public var isAWholeNumber: Bool {
        fatalError()
    }

    @available(*, unavailable, renamed: "isIntegral")
    public var isAnInteger: Bool {
        fatalError()
    }
}
