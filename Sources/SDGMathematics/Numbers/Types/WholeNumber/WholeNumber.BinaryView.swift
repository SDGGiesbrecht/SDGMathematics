/*
 WholeNumber.BinaryView.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

internal struct WholeNumberBinaryView {
    // Cannot conform to Collection, because no SignedInteger is large enough to serve as IndexDistance

    // MARK: - Initialization

    internal init(_ wholeNumber: WholeNumber) {
        self.wholeNumber = wholeNumber
    }

    // MARK: - Properties

    internal var wholeNumber: WholeNumber

    // MARK: - Operations

    internal mutating func shiftLeft(_ distance: IndexDistance) {
        // [_Warning: No implementation yet._]
        fatalError()
    }

    // MARK: - Sequences

    internal func indicesBackwards(from end: Index, to start: Index) -> UnfoldSequence<Index, Index> {
        assert(start ≤ end, "Ascending range: \(end − 1)–\(start)")
        return sequence(state: end) { (index: inout Index) -> Index? in
            guard index ≠ self.startIndex else {
                return nil
            }
            index −= 1
            return index
        }
    }

    internal func indicesBackwards() -> UnfoldSequence<Index, Index> {
        return indicesBackwards(from: endIndex, to: startIndex)
    }

    internal func bitsBackwards(from end: Index, to start: Index) -> LazyMapSequence<UnfoldSequence<Index, Index>, Bool> {
        return indicesBackwards(from: end, to: start).lazy.map() { self[$0] }
    }

    internal func bitsBackwards() -> LazyMapSequence<UnfoldSequence<Index, Index>, Bool> {
        return bitsBackwards(from: endIndex, to: startIndex)
    }

    internal func lastBitsBackwards(maximum distance: IndexDistance) -> LazyMapSequence<UnfoldSequence<Index, Index>, Bool> {
        assert(distance ≥ 0, "Negative distance: \(distance)")

        guard distance ≥ count else {
            return bitsBackwards()
        }
        let start = endIndex − distance
        return bitsBackwards(from: endIndex, to: start)
    }

    // MARK: - Collection

    internal typealias Element = Bool

    internal let startIndex = Index(digit: 0, bit: 0)
    internal var endIndex: Index {
        guard let lastDigitIndex = wholeNumber.digitIndices.last else {
            return Index(digit: 0, bit: 0)
        }

        let lastDigit = wholeNumber[lastDigitIndex]
        let binary = lastDigit.binaryView
        for bitIndex in binary.indices.lazy.reversed() where binary[bitIndex] == true {
            return Index(digit: lastDigitIndex, bit: bitIndex) + 1
        }
        preconditionFailure("\(wholeNumber) is not in normalized form.")
    }
    internal var count: IndexDistance {
        return endIndex − startIndex
    }

    internal subscript(index: Index) -> Element {
        get {
            return wholeNumber[index.digit].binaryView[index.bit]
        }
        set {
            wholeNumber[index.digit].binaryView[index.bit] = newValue
        }
    }
}
