// ComparableExample.swift
//
// This source file is part of the SDGLogic open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGLogic contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

struct ComparableExample: Comparable {
    var value: Int
    
    // Comparable
    
    static func <(lhs: ComparableExample, rhs: ComparableExample) -> Bool {
        return lhs.value < rhs.value
    }
    
    // Equatable
    
    static func ==(lhs: ComparableExample, rhs: ComparableExample) -> Bool {
        return lhs.value == rhs.value
    }
}
