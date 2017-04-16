/*
 UInt.BinaryView.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A view into the bits of a UIntType as a collection.
///
/// Indices ascend leftward.
public struct BinaryView<UIntValue : UIntType> : BidirectionalCollection, Collection, MutableCollection, RandomAccessCollection {

    // MARK: - Initialization

    internal init(_ uInt: UIntValue) {
        self.uInt = uInt
    }

    // MARK: - Static Properties

    /// The end index.
    public static var endIndex: Index {
        return Index(count)
    }
    /// The number of bits.
    public static var count: IndexDistance {
        let bytes = MemoryLayout<UIntValue>.size
        assert(bytes == MemoryLayout<UIntValue>.stride, "\(UIntValue.self) has an incompatible memory layout.")
        return bytes × 8
    }
    /// The last valid index.
    public static var lastIndex: Index {
        return endIndex − 1
    }

    // MARK: - Properties

    internal var uInt: UIntValue

    // MARK: - BidirectionalCollection

    /// Returns the index before `i`.
    public func index(before i: Index) -> Index {
        return i − 1
    }

    // MARK: - Collection

    /// The element type.
    public typealias Element = Bool
    /// The index type.
    public typealias Index = UIntValue
    /// The index distance type.
    public typealias IndexDistance = Int

    /// The start index.
    public let startIndex: Index = 0
    /// The end index.
    public let endIndex: Index = Index(BinaryView.count)

    /// Returns the index after `i`.
    public func index(after i: Index) -> Index {
        return i + 1
    }

    /// Returns the bit at `index`.
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

    /// The index set type.
    public typealias Indices = DefaultRandomAccessIndices<BinaryView>
}
