/*
 FloatingPointPrecision.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

func ≈ <T : Subtractable>(lhs: T, rhs: T) -> Bool where T : Comparable, T : ExpressibleByFloatLiteral {
    return lhs ≈ rhs ± 0.000_01
}
func ≈ <T : Subtractable>(lhs: Angle<T>, rhs: Angle<T>) -> Bool where T : Comparable, T : ExpressibleByIntegerLiteral {
    return lhs.inRadians ≈ rhs.inRadians
}

func πLiteral<T>() -> T where T : ExpressibleByFloatLiteral {
    return 3.141_59
}

func τLiteral<T>() -> T where T : ExpressibleByFloatLiteral {
    return 6.283_18
}

func eLiteral<T>() -> T where T : ExpressibleByFloatLiteral {
    return 2.718_28
}
