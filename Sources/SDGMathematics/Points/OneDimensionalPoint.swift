/*
 OneDimensionalPoint.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A `Comparable` type that can be used with `+(_:_:)` and `−(_:_:)` in conjunction with an associated `Vector` type.
///
/// - Note: For multi‐dimensional points, see `PointType`.
///
/// Conformance Requirements:
///
/// - `PointType`
/// - `Comparable`
public protocol OneDimensionalPoint : Comparable, PointType, Strideable {

}

extension OneDimensionalPoint where Vector : IntegerType {
    // MARK: - where Vector : IntegerType

    // [_Define Documentation: SDGMathematics.OneDimensionalPoint.increment()_]
    /// Advances to the next value.
    public mutating func increment() {
        self += 1
    }

    // [_Define Documentation: SDGMathematics.OneDimensionalPoint.decrement()_]
    /// Retreats to the previous value.
    public mutating func decrement() {
        self −= 1
    }

    // [_Define Documentation: SDGMathematics.OneDimensionalPoint.successor()_]
    /// Returns the value which comes immediately after.
    public func successor() -> Self {
        return self + 1
    }

    // [_Define Documentation: SDGMathematics.OneDimensionalPoint.predecessor()_]
    /// Returns the value which comes immediately before.
    public func predecessor() -> Self {
        return self − 1
    }
}
