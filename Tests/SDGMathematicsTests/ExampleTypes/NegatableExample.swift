// NegatableExample.swift
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

struct NegatableExample: Negatable {
    
    var value: Int
    
    init(_ value: Int) {
        self.value = value
    }
    
    // Addable
    
    static func +=(lhs: inout NegatableExample, rhs: NegatableExample) {
        lhs.value += rhs.value
    }
    
    // AdditiveArithmetic
    
    static var additiveIdentity: NegatableExample {
        return NegatableExample(0)
    }
    
    // Equatable
    
    static func ==(lhs: NegatableExample, rhs: NegatableExample) -> Bool {
        return lhs.value == rhs.value
    }
    
    // Subtractable
    
    static func −=(lhs: inout NegatableExample, rhs: NegatableExample) {
        lhs.value −= rhs.value
    }
}
