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

    internal init(digits: [WholeNumber.Digit]) {
        self.digits = digits
    }

    // MARK: - Properties

    internal var digits: [WholeNumber.Digit]

    // MARK: - Operations

    internal mutating func shiftLeft(_ distance: IndexDistance) {
        // [_Warning: No implementation yet._]
        fatalError()
    }

    // MARK: - Sequences

    internal func indicesBackwards(from end: Index, to start: Index) -> UnfoldSequence<Index, IndexDistance> {
        assert(start ≤ end, "Invalid range: \(end − 1)–\(start)")
        return sequence(state: end − start) { (distance: inout IndexDistance) -> Index? in
            guard distance ≠ 0 else {
                return nil
            }
            distance −= 1
            return start + distance
        }
    }

    internal func indicesBackwards() -> UnfoldSequence<Index, IndexDistance> {
        return indicesBackwards(from: endIndex, to: startIndex)
    }

    internal func bitsBackwards(from end: Index, to start: Index) -> LazyMapSequence<UnfoldSequence<Index, IndexDistance>, Bool> {
        return indicesBackwards(from: end, to: start).lazy.map() { self[$0] }
    }

    internal func bitsBackwards() -> LazyMapSequence<UnfoldSequence<Index, IndexDistance>, Bool> {
        return bitsBackwards(from: endIndex, to: startIndex)
    }

    internal func lastBitsBackwards(maximum distance: IndexDistance) -> LazyMapSequence<UnfoldSequence<Index, IndexDistance>, Bool> {
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
        guard let lastDigitIndex = digits.indices.last else {
            return Index(digit: 0, bit: 0)
        }

        let lastDigit = digits[lastDigitIndex]
        let binary = lastDigit.binaryView
        for bitIndex in binary.indices.lazy.reversed() where binary[bitIndex] == true {
            return Index(digit: lastDigitIndex, bit: bitIndex) + 1
        }
        preconditionFailure("\(digits) is not in normalized form.")
    }
    internal var count: IndexDistance {
        return endIndex − startIndex
    }

    internal subscript(index: Index) -> Element {
        get {
            return digits[index.digit].binaryView[index.bit]
        }
        set {
            digits[index.digit].binaryView[index.bit] = newValue
        }
    }
}
