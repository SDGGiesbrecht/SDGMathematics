/*
 PointTypeExample.swift

 This source file is part of the SDGMathematics open source project.
 https://github.com/SDGGiesbrecht/SDGMathematics

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGMathematics

struct PointTypeExample : PointType {

    var value: UInt

    init(_ value: UInt) {
        self.value = value
    }

    // Equatable

    static func == (lhs: PointTypeExample, rhs: PointTypeExample) -> Bool {
        return lhs.value == rhs.value
    }

    // PointType

    typealias Vector = Int

    static func += (lhs: inout PointTypeExample, rhs: Vector) {
        lhs.value += rhs
    }

    static func − (lhs: PointTypeExample, rhs: PointTypeExample) -> Vector {
        return lhs.value − rhs.value
    }
}
