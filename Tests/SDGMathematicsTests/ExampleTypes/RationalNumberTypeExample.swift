// RationalNumberTypeExample.swift
//
// This source file is part of the SDGLogic open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGLogic contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

@testable import SDGMathematics

struct RationalNumberTypeExample: RationalNumberType {
    
    var value: Double
    
    init(_ value: Double) {
        self.value = value
    }
    
    // Addable
    
    static func +=(lhs: inout RationalNumberTypeExample, rhs: RationalNumberTypeExample) {
        lhs.value += rhs.value
    }
    
    // Comparable
    
    static func <(lhs: RationalNumberTypeExample, rhs: RationalNumberTypeExample) -> Bool {
        return lhs.value < rhs.value
    }
    
    // Equatable
    
    static func ==(lhs: RationalNumberTypeExample, rhs: RationalNumberTypeExample) -> Bool {
        return lhs.value == rhs.value
    }
    
    // ExpressibleByFloatLiteral
    
    init(floatLiteral: Double.FloatLiteralType) {
        value = Double(floatLiteral: floatLiteral)
    }
    
    // ExpressibleByIntegerLiteral
    
    init(integerLiteral: Double.IntegerLiteralType) {
        value = Double(integerLiteral: integerLiteral)
    }
    
    // PointType
    
    typealias Vector = RationalNumberTypeExample
    
    // RationalArithmetic
    
    static func ÷=(lhs: inout RationalNumberTypeExample, rhs: RationalNumberTypeExample) {
        lhs.value ÷= rhs.value
    }
    
    // Strideable
    
    typealias Stride = Vector
    
    // Subtractable
    
    static func −=(lhs: inout RationalNumberTypeExample, rhs: RationalNumberTypeExample) {
        lhs.value −= rhs.value
    }
    
    // WholeArithmetic
    
    static func ×=(lhs: inout RationalNumberTypeExample, rhs: RationalNumberTypeExample) {
        lhs.value ×= rhs.value
    }
    
    mutating func divideAccordingToEuclid(by divisor: RationalNumberTypeExample) {
        value.divideAccordingToEuclid(by: divisor.value)
    }
    
    init(randomInRange range: ClosedRange<RationalNumberTypeExample>, fromRandomizer randomizer: Randomizer) {
        value = Double(randomInRange: range.lowerBound.value ... range.upperBound.value, fromRandomizer: randomizer)
    }
}
