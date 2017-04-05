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

extension WholeNumber {

    @available(*, unavailable, renamed: "isNaturalNumber")
    public var isANaturalNumber: Bool {
        fatalError()
    }
    @available(*, unavailable, renamed: "isWholeNumber")
    public var isAWholeNumber: Bool {
        fatalError()
    }

    @available(*, unavailable, renamed: "isInteger")
    public var isAnInteger: Bool {
        fatalError()
    }
}
