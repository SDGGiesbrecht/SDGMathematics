/*
 Strideable.swift

 This source file is part of the SDGMathematics open source project.
 https://github.com/SDGGiesbrecht/SDGMathematics

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Strideable where Self : OneDimensionalPoint, Self.Stride == Self.Vector {
    // MARK: - where Self : OneDimensionalPoint, Stride == Vector
    
    /// Returns the value that follows `self` by a distance of `n`.
    ///
    /// - Parameters:
    ///     - n: The distance to advance.
    ///
    /// - SeeAlso: `+(_:_:)` (recommended)
    public func advanced(by n: Stride) -> Self {
        return self + n
    }
    
    /// Returns the distance from `self` to `other`.
    ///
    /// - Parameters:
    ///     - other: The value to which the distance should be measured.
    ///
    /// - SeeAlso: `−(_:_:)` (recommended)
    public func distance(to other: Self) -> Stride {
        return other − self
    }
}
