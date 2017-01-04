// OneDimensionalPointExample.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

@testable import SDGMathematics

struct OneDimensionalPointExample: OneDimensionalPoint {
    
    typealias Value = Int64
    
    var value: Value
    
    init(_ value: Value) {
        self.value = value
    }
    
    // Comparable
    
    static func <(lhs: OneDimensionalPointExample, rhs: OneDimensionalPointExample) -> Bool {
        return lhs.value < rhs.value
    }
    
    // Equatable
    
    static func ==(lhs: OneDimensionalPointExample, rhs: OneDimensionalPointExample) -> Bool {
        return lhs.value == rhs.value
    }
    
    // PointType
    
    typealias Vector = Value.Stride
    
    static func +=(lhs: inout OneDimensionalPointExample, rhs: Vector) {
        lhs.value += rhs
    }
    
    static func −(lhs: OneDimensionalPointExample, rhs: OneDimensionalPointExample) -> Vector {
        return lhs.value − rhs.value
    }
    
    // Strideable
    
    typealias Stride = Vector
}
