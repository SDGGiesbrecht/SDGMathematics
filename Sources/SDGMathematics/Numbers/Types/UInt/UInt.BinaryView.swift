/*
 UInt.BinaryView.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public struct BinaryView<UIntValue : UIntType> : BidirectionalCollection, Collection, MutableCollection, RandomAccessCollection {

    // MARK: - Initialization

    internal init(_ uInt: UIntValue) {
        self.uInt = uInt
    }

    // MARK: - Static Properties

    public static var endIndex: Index {
        return Index(count)
    }
    public static var count: IndexDistance {
        let bytes = MemoryLayout<UIntValue>.size
        assert(bytes == MemoryLayout<UIntValue>.stride, "\(UIntValue.self) has an incompatible memory layout.")
        return bytes × 8
    }
    public static var lastIndex: Index {
        return endIndex − 1
    }

    // MARK: - Properties

    internal var uInt: UIntValue

    // MARK: - BidirectionalCollection

    public func index(before i: Index) -> Index {
        return i − 1
    }

    // MARK: - Collection

    public typealias Element = Bool
    public typealias Index = UIntValue
    public typealias IndexDistance = Int

    public let startIndex: Index = 0
    public let endIndex: Index = Index(BinaryView.count)

    public func index(after i: Index) -> Index {
        return i + 1
    }

    public subscript(index: Index) -> Element {
        get {
            assert((startIndex ..< endIndex).contains(index), "Index out of bounds. \(index) ∈ \(startIndex)–\(endIndex − 1)")
            return (uInt & (1 << index)) >> index == 1
        }
        set {
            assert((startIndex ..< endIndex).contains(index), "Index out of bounds. \(index) ∈ \(startIndex)–\(endIndex − 1)")
            let oldErased = uInt & ~(1 << index)
            uInt = oldErased | ((newValue ? 1 : 0) << index)
        }
    }

    // MARK: - RandomAccessCollection

    public typealias Indices = DefaultRandomAccessIndices<BinaryView>
}
