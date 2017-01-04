// Equatable.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

extension Equatable where Self : Measurement {
    // MARK: - where Self : Measurement
    
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - lhs: A value.
    ///     - rhs: Another value.
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
