/*
 UInt.HalvesView.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal struct HalvesView<UIntValue : UIntType> : BidirectionalCollection, Collection, MutableCollection, RandomAccessCollection {

    // MARK: - Initialization

    internal init(_ uInt: UIntValue) {
        self.uInt = uInt
    }

    // MARK: - Static Properties

    internal static var count: IndexDistance {
        return 2
    }

    // MARK: - Properties

    internal var uInt: UIntValue

    private typealias BinarySize = UIntValue
    private var elementSize: BinarySize {
        let totalSize = BinarySize(BinaryView<UIntValue>.count)
        let elementCount = BinarySize(count)
        assert(totalSize.isDivisible(by: elementCount), "\(UIntValue.self) has an incompatible memory layout.")
        return totalSize.dividedAccordingToEuclid(by: elementCount)
    }

    private var elementMask: UIntValue {
        return (1 << elementSize) − 1
    }

    // MARK: - BidirectionalCollection

    internal func index(before i: Index) -> Index {
        return i − 1
    }

    // MARK: - Collection

    internal typealias Element = UIntValue
    internal typealias Index = UIntValue
    internal typealias IndexDistance = Int

    internal let startIndex: Index = 0
    internal let endIndex: Index = Index(HalvesView.count)

    internal func index(after i: Index) -> Index {
        return i + 1
    }

    internal subscript(index: Index) -> Element {
        get {
            assert(index < endIndex, "Index out of bounds. \(index) ∈ \(startIndex)–\(endIndex − 1)")
            let offset = index × elementSize
            return (uInt & (elementMask << offset)) >> offset
        }
        set {
            assert(index < endIndex, "Index out of bounds. \(index) ∈ \(startIndex)–\(endIndex − 1)")
            let offset = index × elementSize
            let oldErased = uInt & ~(elementMask << offset)
            uInt = oldErased | (newValue << offset)
        }
    }

    // MARK: - RandomAccessCollection

    internal typealias Indices = DefaultRandomAccessIndices<HalvesView>
}
