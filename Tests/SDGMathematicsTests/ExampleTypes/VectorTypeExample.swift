// VectorTypeExample.swift
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

struct VectorTypeExample: VectorType {
    
    var value: Double
    
    init(_ value: Double) {
        self.value = value
    }
    
    // Addable
    
    static func +=(lhs: inout VectorTypeExample, rhs: VectorTypeExample) {
        lhs.value += rhs.value
    }
    
    // Equatable
    
    static func ==(lhs: VectorTypeExample, rhs: VectorTypeExample) -> Bool {
        return lhs.value == rhs.value
    }
    
    // AdditiveArithmetic
    
    static var additiveIdentity: VectorTypeExample {
        return VectorTypeExample(0)
    }
    
    // VectorType
    
    typealias Scalar = Double
    
    static func ×=(lhs: inout VectorTypeExample, rhs: Scalar) {
        lhs.value ×= rhs
    }
    
    static func ÷=(lhs: inout VectorTypeExample, rhs: Scalar) {
        lhs.value ÷= rhs
    }
    
    // Subtractable
    
    static func −=(lhs: inout VectorTypeExample, rhs: VectorTypeExample) {
        lhs.value −= rhs.value
    }
}
