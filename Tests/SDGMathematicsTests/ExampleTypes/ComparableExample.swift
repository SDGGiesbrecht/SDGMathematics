/*
 ComparableExample.swift

 This source file is part of the SDGMathematics open source project.
 https://github.com/SDGGiesbrecht/SDGMathematics

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
