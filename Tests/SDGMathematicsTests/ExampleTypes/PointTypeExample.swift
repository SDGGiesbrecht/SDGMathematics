// PointTypeExample.swift
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

struct PointTypeExample: PointType {
    
    var value: UInt
    
    init(_ value: UInt) {
        self.value = value
    }
    
    // Equatable
    
    static func ==(lhs: PointTypeExample, rhs: PointTypeExample) -> Bool {
        return lhs.value == rhs.value
    }
    
    // PointType
    
    typealias Vector = Int
    
    static func +=(lhs: inout PointTypeExample, rhs: Vector) {
        lhs.value += rhs
    }
    
    static func −(lhs: PointTypeExample, rhs: PointTypeExample) -> Vector {
        return lhs.value − rhs.value
    }
}
