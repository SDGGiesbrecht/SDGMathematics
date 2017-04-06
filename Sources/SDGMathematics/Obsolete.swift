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

infix operator ≤=: AssignmentPrecedence

extension Comparable {

    @available(*, unavailable, message: "Use “lhs.decrease(to: rhs)” instead.")
    public static func ≤= (lhs: inout Self, rhs: Self) {
        if lhs > rhs {
            lhs = rhs
        }
    }
}

infix operator ≥=: AssignmentPrecedence

extension Comparable {

    @available(*, unavailable, message: "Use “lhs.increase(to: rhs)” instead.")
    public static func ≥= (lhs: inout Self, rhs: Self) {
        if lhs < rhs {
            lhs = rhs
        }
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
