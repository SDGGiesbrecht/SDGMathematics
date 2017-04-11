/*
 Integer.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An arbitrary‐precision integer.
public struct Integer {

    // MARK: - Properties

    private var magnitude: WholeNumber
    public private(set) var isNegative: Bool

    // MARK: - Normalization

    private mutating func normalize() {

    }
}
