/*
 APITests.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGLogic

import SDGMathematics

typealias Integer = SDGMathematics.Integer

class APITests : XCTestCase {

    func testAddable() {
        func runTests<T : Addable>(addend: T, augend: T, sum: T) where T : Equatable {
            XCTAssert(addend + augend == sum)
        }

        runTests(addend: 1, augend: 2, sum: 3)
        runTests(addend: 1 as WholeNumber, augend: 2, sum: 3)
        runTests(addend: 1 as Integer, augend: 2, sum: 3)
        runTests(addend: 1 as RationalNumber, augend: 2, sum: 3)
        runTests(addend: AddableExample(1), augend: AddableExample(2), sum: AddableExample(3))
        runTests(addend: AddableExampleWhereStrideableAndStrideIsSelf(1), augend: AddableExampleWhereStrideableAndStrideIsSelf(2), sum: AddableExampleWhereStrideableAndStrideIsSelf(3))
    }

    func testAngle() {
        func runTests<N : RealArithmetic>(_ type: N.Type) {
            let _1: N = 1
            var variable: Angle<N> = _1.rad

            XCTAssert((_1 × τ()).rad == _1.rotations)
            XCTAssert((_1 × τ()).rad.inRotations == _1)

            let πValue: N = πLiteral()
            XCTAssert((_1 × 180)° ≈ πValue.rad)
            XCTAssert((_1 × 6)°.inDegrees ≈ _1 × 6)
            XCTAssert((_1 × 60)′ == _1°)
            XCTAssert((_1 × 6)′.inMinutes ≈ _1 × 6)
            XCTAssert((_1 × 60)′′ == _1′)
            XCTAssert((_1 × 6)′′.inSeconds ≈ _1 × 6)

            XCTAssert((_1 × 200).gradians ≈ πValue.rad)
            XCTAssert((_1 × 6).gradians.inGradians ≈ _1 × 6)

            variable = _1.rad
            variable += _1.rad
            XCTAssert(variable == (_1 × 2).rad)

            variable = _1.rad
            variable −= _1.rad
            XCTAssert(variable == Angle<N>.additiveIdentity)

            variable = _1.rad
            variable−=
            XCTAssert(variable == (−_1).rad)

            XCTAssert(|(−_1.rad)| == _1.rad)
            variable = (_1.rad)
            variable.formAbsoluteValue()
            XCTAssert(variable == _1.rad)

            XCTAssert(_1.rad × 2 == (_1 × 2).rad)
            XCTAssert(4 × _1.rad == (_1 × 4).rad)
            XCTAssert(_1.rad ÷ (_1 ÷ 2).rad ≈ _1 × 2)
            XCTAssert((_1 × 3).rad.dividedAccordingToEuclid(by: (_1 × 2).rad) == 1)
            XCTAssert((_1 × 2).rad.isDivisible(by: _1.rad))
            let _1_5 = gcd((_1 × 1.5).rad, (_1 × 3).rad)
            let _1_5b = gcd((_1 × 3).rad, (_1 × 1.5).rad)
            XCTAssert(_1_5 ≈ (_1 × 1.5).rad)
            XCTAssert(_1_5 == _1_5b)
            XCTAssert(lcm((_1 × 1.5).rad, (_1 × 0.5).rad) ≈ (_1 × 1.5).rad)

            XCTAssert(_1.rad.rounded(.down, toMultipleOf: _1.rad × 2) == _1.rad × 0)

            XCTAssert(_1.rad.isPositive)
            XCTAssert((−_1).rad.isNegative)
            XCTAssert(Angle<N>.additiveIdentity.isNonPositive)
            XCTAssert(Angle<N>.additiveIdentity.isNonNegative)

            for _ in 1 ..< 100 {
                let random = Angle(randomInRange: N.additiveIdentity.rad ..< _1.rad)
                XCTAssert((N.additiveIdentity.rad ..< _1.rad).contains(random))
                let random2 = Angle(randomInRange: N.additiveIdentity.rad ... _1.rad)
                XCTAssert((N.additiveIdentity.rad ... _1.rad).contains(random2))
            }
        }
        runTests(Double.self)
        #if os(macOS) || os(Linux)
        runTests(Float80.self)
        #endif
        runTests(Float.self)
        runTests(RealArithmeticExample.self)
    }

    func testArbitraryPrecision() {
        let undecillion: WholeNumber = "1 000 000 000 000 000 000 000 000 000 000 000 000"
        let billion: WholeNumber = 1_000_000_000
        XCTAssert(billion ↑ 4 == undecillion)

        XCTAssert(undecillion.dividedAccordingToEuclid(by: (billion ↑ 3)) == billion)

        let value: WholeNumber = "66 296 448 936 247 622 620"
        XCTAssert(value.dividedAccordingToEuclid(by: 4) == "16 574 112 234 061 905 655")

        let anotherValue: WholeNumber = "18 446 744 073 709 551 616"
        XCTAssert(anotherValue.dividedAccordingToEuclid(by: 1) == anotherValue)

        func runStringLiteralTests<N : WholeArithmetic>(_ type: N.Type) where N : ExpressibleByStringLiteral {
            let one: N = "1"
            XCTAssert(one == 1)
        }
        runStringLiteralTests(WholeNumber.self)
        runStringLiteralTests(Integer.self)
        runStringLiteralTests(RationalNumber.self)

        XCTAssert(RationalNumber(undecillion).numerator.magnitude == undecillion)

        let rational: RationalNumber = "0b 0.000 1"
        XCTAssert(rational == 1 ÷ 16)
    }

    func testBool() {
        var values: Set<Bool> = []
        for _ in 1 ..< 100 {
            values.insert(Bool.random())
        }
        XCTAssert(values.count == 2)
    }

    func testComparable() {
        XCTAssert(ComparableExample(value: −1) < ComparableExample(value: 0))
        XCTAssertFalse(ComparableExample(value: 0) < ComparableExample(value: 0))
        XCTAssertFalse(ComparableExample(value: 1) < ComparableExample(value: 0))

        XCTAssert(ComparableExample(value: −1) ≤ ComparableExample(value: 0))
        XCTAssert(ComparableExample(value: 0) ≤ ComparableExample(value: 0))
        XCTAssertFalse(ComparableExample(value: 1) ≤ ComparableExample(value: 0))

        XCTAssertFalse(ComparableExample(value: −1) ≥ ComparableExample(value: 0))
        XCTAssert(ComparableExample(value: 0) ≥ ComparableExample(value: 0))
        XCTAssert(ComparableExample(value: 1) ≥ ComparableExample(value: 0))

        let list = [1, 4, 1, 5]
        var value = 3

        for entry in list {
            value.decrease(to: entry)
        }
        XCTAssert(value == 1)

        for entry in list {
            value.increase(to: entry)
        }
        XCTAssert(value == 5)

        XCTAssert(1 ≈ (0, 2))
    }

    func testDouble() {
        #if os(Linux)
        #else
            XCTAssert(¬CGFloat(28).debugDescription.isEmpty)
            XCTAssert(CGFloat("1") ≠ nil)
            XCTAssert(CGFloat("a") == nil)
        #endif
    }

    func testFunctionAnalysis() {
        let negativeQuatratic = {
            (input: Int) -> Int in
            return −(input ↑ 2)
        }
        XCTAssert(findLocalMaximum(near: 10, inFunction: negativeQuatratic) == 0, "Failed to find local maximum.")

        XCTAssert(findLocalMaximum(near: 10, within: 5...15, inFunction: negativeQuatratic) == 5, "Failed to find local maximum.")
        XCTAssert(findLocalMaximum(near: −10, inFunction: negativeQuatratic) == 0, "Failed to find local maximum.")

        let quatratic = {
            (input: Int) -> Int in
            return (input ↑ 2)
        }

        XCTAssert(findLocalMinimum(near: 10, inFunction: quatratic) == 0, "Failed to find local minimum.")

        XCTAssert(findLocalMinimum(near: 10, within: 5...15, inFunction: quatratic) == 5, "Failed to find local minimum.")
    }

    func testIntegralArithmetic() {

        func runTests<N : IntegralArithmetic>(_ type: N.Type) {
            let minusTwo: N = −2
            let minusOne: N = −1
            let one: N = 1
            let two: N = 2
            let three: N = 3

            XCTAssert(minusOne.isNonPositive)
            XCTAssert(minusOne.isNegative)

            XCTAssert(|minusOne| == one)
            /* Swift.AbsoluteValuable */ XCTAssert(abs(minusOne) == one)

            XCTAssert(−one == minusOne)
            /* Swift.SignedNumber */ XCTAssert(-one == minusOne)
            /* Swift.SignedNumber */ XCTAssert(one - minusOne == two)

            XCTAssert(three.dividedAccordingToEuclid(by: −two) == −two)
            XCTAssert((−three).dividedAccordingToEuclid(by: two) == −two)
            XCTAssert(gcd(one × −12, −8) == 4)

            for _ in 1 ... 100 {
                let random = N(randomInRange: 3 ... 7)
                XCTAssert((3 ... 7).contains(random), "\(random) ∉ 3–7")
                let negativeRandom = N(randomInRange: −10 ... −4)
                XCTAssert((−10 ... −4).contains(negativeRandom), "\(negativeRandom) ∉ −10 to −4")
            }

            XCTAssert(minusTwo < minusOne)

            // Previous Bugs

            var x: N = 0
            x −= 1
            XCTAssert(x == −1)
            XCTAssert(x − 1 == −2)
            x += 1
            XCTAssert(x == 0)
            XCTAssert(x + 1 == 1)
        }
        runTests(Int.self)
        runTests(Int64.self)
        runTests(Int32.self)
        runTests(Int16.self)
        runTests(Int8.self)
        runTests(Double.self)
        runTests(Float.self)
        runTests(Integer.self)
        runTests(RationalNumber.self)
        runTests(RealArithmeticExample.self)

        func runStrideableTests<N : IntegralArithmetic>(_ type: N.Type) where N : Strideable, N.Stride == N {
            let _1: N = 1
            XCTAssert(_1.advanced(by: 1) == _1 + 1)

            XCTAssert(N.additiveIdentity.distance(to: _1) == _1)
        }
        runStrideableTests(Int.self)
        runStrideableTests(Double.self)
        runStrideableTests(Float.self)
        runStrideableTests(RealArithmeticExample.self)
    }

    func testNegatable() {
        func runTests<N : Negatable>(_ type: N.Type, value: N, inverse: N) {
            var variable = value
            variable−=
            XCTAssert(variable == inverse)
        }

        runTests(Int.self, value: 1, inverse: −1)
        runTests(Int64.self, value: 1, inverse: −1)
        runTests(Int32.self, value: 1, inverse: −1)
        runTests(Int16.self, value: 1, inverse: −1)
        runTests(Int8.self, value: 1, inverse: −1)
        runTests(Double.self, value: 1, inverse: −1)
        #if os(macOS) || os(Linux)
        runTests(Float80.self, value: 1, inverse: −1)
        #endif
        runTests(Float.self, value: 1, inverse: −1)
        runTests(Integer.self, value: 1, inverse: −1)
        runTests(RationalNumber.self, value: 1, inverse: −1)
        runTests(NegatableExample.self, value: NegatableExample(1), inverse: NegatableExample(−1))
    }

    func testOneDimensionalPoint() {

        var x = 1
        x.decrement()
        XCTAssert(x == 0)

        func runStrideableTests<N : OneDimensionalPoint>(start: N, end: N, vector: N.Vector) where N : Strideable, N.Vector == N.Stride {
            XCTAssert(start.advanced(by: vector) == end)

            XCTAssert(start.distance(to: end) == vector)
        }
        runStrideableTests(start: Int64(0), end: 1, vector: 1)
        runStrideableTests(start: Int32(0), end: 1, vector: 1)
        runStrideableTests(start: Int16(0), end: 1, vector: 1)
        runStrideableTests(start: Int8(0), end: 1, vector: 1)
        runStrideableTests(start: OneDimensionalPointExample(0), end: OneDimensionalPointExample(1), vector: 1)
    }

    func testPointType() {
        func runTests<P : PointType>(start: P, distance: P.Vector, end: P) {
            var variable = start
            variable += distance
            XCTAssert(variable == end)
            variable −= distance
            XCTAssert(variable == start)

            XCTAssert(start + distance == end)
            XCTAssert(end − distance == start)
            XCTAssert(end − start == distance)
        }
        runTests(start: Int64(0), distance: 3, end: 3)
        runTests(start: UInt64(0), distance: 3, end: 3)
        runTests(start: 0 as WholeNumber, distance: 3, end: 3)
        runTests(start: 0 as Integer, distance: 3, end: 3)
        runTests(start: 0 as RationalNumber, distance: 3, end: 3)
        runTests(start: PointTypeExample(0), distance: 3, end: PointTypeExample(3))
        runTests(start: PointTypeExampleWhereVectorIsSelf(0), distance: PointTypeExampleWhereVectorIsSelf(3), end: PointTypeExampleWhereVectorIsSelf(3))
    }

    func testRandomizer() {
        func runTests<R : Randomizer>(_ randomizer: R) {

            var uInt64sReturned: Set<UInt64> = []
            var int64sReturned: Set<Int64> = []
            var positiveInt64sReturned: Set<Int64> = []

            for _ in 1 ... 100 {
                let random = randomizer.randomNumber(inRange: 1 ... 6)
                uInt64sReturned.insert(random)
                XCTAssert(1 ≤ random ∧ random ≤ 6)

                let randomInt = Int64(randomInRange: −3 ... 3)
                int64sReturned.insert(randomInt)
                XCTAssert(−3 ≤ randomInt ∧ randomInt ≤ 3)

                let randomPositiveInt = Int64(randomInRange: 1 ... 6)
                positiveInt64sReturned.insert(randomPositiveInt)
                XCTAssert(1 ≤ randomPositiveInt ∧ randomPositiveInt ≤ 6)

                let randomDouble = Double(randomInRange: −3 ... 3)
                XCTAssert(−3 ≤ randomDouble ∧ randomDouble ≤ 3)
            }

            if R.self == PseudorandomNumberGenerator.self {
                XCTAssert(uInt64sReturned.count == 6)
                XCTAssert(int64sReturned.count == 7)
                XCTAssert(positiveInt64sReturned.count == 6)
            }
        }
        runTests(CyclicalNumberGenerator([0, 1, 6, 7, 11, 12, UInt64.max]))
        runTests(PseudorandomNumberGenerator.defaultGenerator)
    }

    func testRationalArithmetic() {
        func runTests<N : RationalArithmetic>(_ type: N.Type) {
            let one: N = 1
            let oneAndAHalf: N = 1.5
            let two: N = 2
            let three: N = 3

            var variable = three
            variable ÷= two
            XCTAssert(variable == oneAndAHalf)

            XCTAssert(two ↑ −two == one ÷ two ÷ two)

            XCTAssert(oneAndAHalf.rounded(.up) == two)
            XCTAssert(oneAndAHalf.rounded(.towardZero) == one)
            XCTAssert((−oneAndAHalf).rounded(.towardZero) == −one)
            XCTAssert(oneAndAHalf.rounded(.awayFromZero) == two)
            XCTAssert((−oneAndAHalf).rounded(.awayFromZero) == −two)
            XCTAssert(oneAndAHalf.rounded(.toNearestOrEven) == two)
            XCTAssert(oneAndAHalf.rounded(.toNearestOrAwayFromZero) == two)
            XCTAssert((one × 0.75).rounded(.toNearestOrEven) == one)
            XCTAssert((one × 0.25).rounded(.toNearestOrEven) == 0)
            XCTAssert((one × −1.5).rounded(.toNearestOrAwayFromZero) == −2)
            XCTAssert((one × 0.5).rounded(.toNearestOrEven) == 0)
            variable = 2.5
            variable.round(.toNearestOrAwayFromZero)
            XCTAssert(variable == 3)

            for _ in 1 ..< 100 {let random = N(randomInRange: 0 ..< 1)
                XCTAssert((0 ..< 1).contains(random))
            }
        }
        runTests(Double.self)
        #if os(macOS) || os(Linux)
        runTests(Float80.self)
        #endif
        runTests(Float.self)
        runTests(RationalNumber.self)
        runTests(RationalNumberTypeExample.self)
        runTests(RealArithmeticExample.self)

        // Previous Bugs

        _ = Double(1) ÷ Double(1)
    }

    func testRealArithmetic() {
        func runTests<N : RealArithmetic>(_ type: N.Type) {
            let _1: N = 1
            var variable: N = 0

            let πValue: N = πLiteral()
            XCTAssert(N.π ≈ πValue)
            XCTAssert(N.π == π())
            XCTAssert(N.π == N.π.π)

            let τValue: N = τLiteral()
            XCTAssert(N.τ ≈ τValue)
            XCTAssert(N.τ == τ())
            XCTAssert(N.τ == N.τ.τ)

            let eValue: N = eLiteral()
            XCTAssert(N.e ≈ eValue)
            XCTAssert(N.e == e())
            XCTAssert(N.e == N.e.e)

            XCTAssert(√(_1 × 2) ≈ _1 × 1.414_21)
            XCTAssert((_1 × 81).root(ofDegree: 4) ≈ 3)
            XCTAssert((_1 × 27).root(ofDegree: 3) ≈ 3)
            variable = 1
            variable√=
            XCTAssert(variable == 1)

            XCTAssert(log(toBase: 9, of: 3 × _1) ≈ _1 × 0.5)
            XCTAssert(log(_1 × 10) ≈ 1)
            XCTAssert(ln(_1 × 2) ≈ 0.693_14 as N)
            XCTAssert(ln(_1 × 80) ≈ 4.382_02 as N)

            XCTAssert(sin(_1.rad ÷ 2) ≈ 0.479_42 as N)
            XCTAssert(sin(_1°) ≈ 0.017_45 as N)
            XCTAssert(cos(_1.rad ÷ 3) ≈ 0.944_95 as N)
            XCTAssert(cos(_1.rad × −π()) ≈ −1)
            XCTAssert(tan(_1.rad × 5) ≈ −3.380_52 as N)
            XCTAssert(csc(_1.rad) ≈ 1.188_39 as N)
            XCTAssert(sec(_1.rad × 2) ≈ −2.403_00 as N)
            XCTAssert(cot(_1.rad × 3) ≈ −7.015_26 as N)

            XCTAssert(arcsin(_1 ÷ 6) ≈ (0.167_44 as N).rad)
            XCTAssert(arccos(_1 ÷ 7) ≈ (1.427_44 as N).rad)
            XCTAssert(arctan(_1 ÷ 2) ≈ (0.463_64 as N).rad)
            XCTAssert(arctan(_1 × 2) ≈ (1.107_14 as N).rad)
            XCTAssert(arccsc(_1 × 3) ≈ (0.339_83 as N).rad)
            XCTAssert(arcsec(_1 × 4) ≈ (1.318_11 as N).rad)
            XCTAssert(arccot(_1 × 5) ≈ (0.197_39 as N).rad)
            XCTAssert(arccot(_1 × −2) ≈ (2.677_94 as N).rad)
        }
        runTests(Double.self)
        #if os(macOS) || os(Linux)
        runTests(Float80.self)
        #endif
        runTests(Float.self)
        runTests(RealArithmeticExample.self)
    }

    func testSubtractable() {

        func runTests<T : Subtractable>(minuend: T, subtrahend: T, difference: T) where T : Equatable {
            XCTAssert(minuend − subtrahend == difference)
        }
        runTests(minuend: UInt(3), subtrahend: 2, difference: 1)
        runTests(minuend: UInt64(3), subtrahend: 2, difference: 1)
        runTests(minuend: UInt32(3), subtrahend: 2, difference: 1)
        runTests(minuend: UInt16(3), subtrahend: 2, difference: 1)
        runTests(minuend: UInt8(3), subtrahend: 2, difference: 1)
        runTests(minuend: Int(3), subtrahend: 2, difference: 1)
        runTests(minuend: Int64(3), subtrahend: 2, difference: 1)
        runTests(minuend: Int32(3), subtrahend: 2, difference: 1)
        runTests(minuend: Int16(3), subtrahend: 2, difference: 1)
        runTests(minuend: Int8(3), subtrahend: 2, difference: 1)
        runTests(minuend: Double(3), subtrahend: 2, difference: 1)
        runTests(minuend: Float(3), subtrahend: 2, difference: 1)
        runTests(minuend: 3 as WholeNumber, subtrahend: 2, difference: 1)
        runTests(minuend: 3 as Integer, subtrahend: 2, difference: 1)
        runTests(minuend: 3 as RationalNumber, subtrahend: 2, difference: 1)
        runTests(minuend: SubtractableExample(3), subtrahend: SubtractableExample(2), difference: SubtractableExample(1))
        runTests(minuend: SubtractableExampleWherePointTypeAndVectorIsSelf(3), subtrahend: SubtractableExampleWherePointTypeAndVectorIsSelf(2), difference: SubtractableExampleWherePointTypeAndVectorIsSelf(1))
        runTests(minuend: RationalNumberTypeExample(3), subtrahend: RationalNumberTypeExample(2), difference: RationalNumberTypeExample(1))
        runTests(minuend: RealArithmeticExample(3), subtrahend: RealArithmeticExample(2), difference: RealArithmeticExample(1))

        // Previous Bugs

        // “ambiguous use of operator”
        let _: UInt = 3 − 2
        let _: UInt64 = 3 − 2
        let _: UInt32 = 3 − 2
        let _: UInt16 = 3 − 2
        let _: UInt8 = 3 − 2
        let _: Int = 3 − 2
        let _: Int64 = 3 − 2
        let _: Int32 = 3 − 2
        let _: Int16 = 3 − 2
        let _: Int8 = 3 − 2
        let _: Double = 3 − 2
        #if os(macOS) || os(Linux)
        let _: Float80 = 3 − 2
        #endif
        let _: Float = 3 − 2
        let _: WholeNumber = 3 − 2
        let _: Integer = 3 − 2
        let _: RationalNumberTypeExample = RationalNumberTypeExample(3) − RationalNumberTypeExample(2)
        let _: RealArithmeticExample = RealArithmeticExample(3) − RealArithmeticExample(2)
    }

    func testTuple() {
        XCTAssertFalse((0, 1) ≤ (0, 0))
        XCTAssert((0, 1) ≤ (0, 1))
        XCTAssert((0, 1) ≤ (1, 1))

        XCTAssertFalse((0, 0, 1) ≤ (0, 0, 0))
        XCTAssert((0, 0, 1) ≤ (0, 0, 1))
        XCTAssert((0, 0, 1) ≤ (0, 1, 1))

        XCTAssertFalse((0, 0, 0, 1) ≤ (0, 0, 0, 0))
        XCTAssert((0, 0, 0, 1) ≤ (0, 0, 0, 1))
        XCTAssert((0, 0, 0, 1) ≤ (0, 0, 1, 1))

        XCTAssertFalse((0, 0, 0, 0, 1) ≤ (0, 0, 0, 0, 0))
        XCTAssert((0, 0, 0, 0, 1) ≤ (0, 0, 0, 0, 1))
        XCTAssert((0, 0, 0, 0, 1) ≤ (0, 0, 0, 1, 1))

        XCTAssertFalse((0, 0, 0, 0, 0, 1) ≤ (0, 0, 0, 0, 0, 0))
        XCTAssert((0, 0, 0, 0, 0, 1) ≤ (0, 0, 0, 0, 0, 1))
        XCTAssert((0, 0, 0, 0, 0, 1) ≤ (0, 0, 0, 0, 1, 1))

        XCTAssert((0, 1) ≥ (0, 0))
        XCTAssert((0, 1) ≥ (0, 1))
        XCTAssertFalse((0, 1) ≥ (1, 1))

        XCTAssert((0, 0, 1) ≥ (0, 0, 0))
        XCTAssert((0, 0, 1) ≥ (0, 0, 1))
        XCTAssertFalse((0, 0, 1) ≥ (0, 1, 1))

        XCTAssert((0, 0, 0, 1) ≥ (0, 0, 0, 0))
        XCTAssert((0, 0, 0, 1) ≥ (0, 0, 0, 1))
        XCTAssertFalse((0, 0, 0, 1) ≥ (0, 0, 1, 1))

        XCTAssert((0, 0, 0, 0, 1) ≥ (0, 0, 0, 0, 0))
        XCTAssert((0, 0, 0, 0, 1) ≥ (0, 0, 0, 0, 1))
        XCTAssertFalse((0, 0, 0, 0, 1) ≥ (0, 0, 0, 1, 1))

        XCTAssert((0, 0, 0, 0, 0, 1) ≥ (0, 0, 0, 0, 0, 0))
        XCTAssert((0, 0, 0, 0, 0, 1) ≥ (0, 0, 0, 0, 0, 1))
        XCTAssertFalse((0, 0, 0, 0, 0, 1) ≥ (0, 0, 0, 0, 1, 1))
    }

    func testVectorType() {
        XCTAssert(3 × VectorTypeExample(2) == VectorTypeExample(6))
        XCTAssert(VectorTypeExample(6) ÷ 3 == VectorTypeExample(2))
    }

    func testWholeArithmetic() {
        func runTests<N : WholeArithmetic>(_ type: N.Type) {
            let zero: N = 0
            let one: N = 1
            let two: N = 2
            let three: N = 3

            var variable = zero

            XCTAssert(zero == N.additiveIdentity)

            XCTAssert(one + one == two)

            variable = zero
            variable += one
            XCTAssert(variable == one)

            variable = two
            variable −= two
            XCTAssert(variable == zero)

            XCTAssert(two − one == one)

            XCTAssert(|two| == 2)

            XCTAssert(two × one == two)
            variable = one
            variable ×= two
            XCTAssert(one × two == two)

            variable = three
            variable.formRemainder(mod: 2)
            XCTAssert(variable == 1)

            XCTAssert(lcm(two, 3) == 6)

            XCTAssert(two ↑ 3 == 8)

            XCTAssert(one.isPositive)
            XCTAssert(one.isNonNegative)

            XCTAssert(zero.isNonNegative)
            XCTAssert(zero.isNonPositive)

            XCTAssert(two.isNatural)
            XCTAssert(one.isIntegral)
            XCTAssert(two.isEven)
            XCTAssert(one.isOdd)

            XCTAssert(one.rounded(.down) == one)

            for _ in 1 ... 100 {
                XCTAssert((17 ... 28).contains(N(randomInRange: 17 ... 28)))
            }

            let uInt8: UInt8 = 94
            XCTAssert(N(uInt8) == 94)

            // Previous Bugs

            let five: N = 10 − 5
            XCTAssert(five == 5)
        }
        runTests(UInt.self)
        runTests(UInt64.self)
        runTests(UInt32.self)
        runTests(UInt16.self)
        runTests(UInt8.self)
        runTests(Int.self)
        runTests(Int64.self)
        runTests(Int32.self)
        runTests(Int16.self)
        runTests(Int8.self)
        runTests(Double.self)
        runTests(Float.self)
        runTests(WholeNumber.self)
        runTests(Integer.self)
        runTests(RationalNumber.self)
    }

    static var allTests: [(String, (APITests) -> () throws -> Void)] {
        return [
            ("testAddable", testAddable),
            ("testAngle", testAngle),
            ("testArbitraryPrecision", testArbitraryPrecision),
            ("testBool", testBool),
            ("testComparable", testComparable),
            ("testDouble", testDouble),
            ("testFunctionAnalysis", testFunctionAnalysis),
            ("testIntegralArithmetic", testIntegralArithmetic),
            ("testNegatable", testNegatable),
            ("testOneDimensionalPoint", testOneDimensionalPoint),
            ("testPointType", testPointType),
            ("testRandomizer", testRandomizer),
            ("testRationalArithmetic", testRationalArithmetic),
            ("testRealArithmetic", testRealArithmetic),
            ("testSubtractable", testSubtractable),
            ("testTuple", testTuple),
            ("testVectorType", testVectorType),
            ("testWholeArithmetic", testWholeArithmetic)
        ]
    }
}
