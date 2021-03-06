/*
 CyclicalNumberGenerator.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A “random” number generator that returns numbers in a pre‐determined cycle.
public final class CyclicalNumberGenerator : Randomizer {

    private let sequence: [UIntMax]
    private var index: Array<UIntMax>.Index

    /// Creates a cyclical number generator that returns numbers according to `sequence`.
    ///
    /// - Precondition: `sequence` is not empty.
    ///
    /// - Parameters:
    ///     - sequence: The sequence.
    public init(_ sequence: [UIntMax]) {
        assert(¬sequence.isEmpty, "Empty sequence.")

        self.sequence = sequence
        self.index = sequence.startIndex
    }

    // MARK: - Randomizer

    /// Returns the next value in the sequence.
    public func randomNumber() -> UIntMax {

        let result = sequence[index]

        index.increment()
        if index == sequence.endIndex {
            index = sequence.startIndex
        }

        return result
    }
}
