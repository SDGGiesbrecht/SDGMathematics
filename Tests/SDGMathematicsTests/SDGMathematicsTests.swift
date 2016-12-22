// SDGMathematicsTests.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

import XCTest

// swiftlint:disable disjunction
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
// swiftlint:enable disjunction
    
    import Foundation
#endif

import SDGLogic

@testable import SDGMathematics

class SDGMathematicsTests: XCTestCase {
    
    func testAngle() {
        func runTests<N: RealArithmetic>(_ type: N.Type) {
            let _1: N = 1
            var variable: Angle<N> = _1.rad
            
            XCTAssert((_1 × τ()).rad == _1.rotations)
            XCTAssert((_1 × τ()).rad.inRotations == _1)
            
            XCTAssert(((_1 × 3.141_59).rad ..< (_1 × 3.141_60).rad).contains((_1 × 180)°))
            XCTAssert(((_1 × 5.999_99)°.inDegrees ..< (_1 × 6.000_01)°.inDegrees).contains(_1 × 6))
            XCTAssert((_1 × 60)′ == _1°)
            XCTAssert(((_1 × 5.999_99)′.inMinutes ..< (_1 × 6.000_01)′.inMinutes).contains(_1 × 6))
            XCTAssert((_1 × 60)′′ == _1′)
            XCTAssert(((_1 × 5.999_99)′′.inSeconds ..< (_1 × 6.000_01)′′.inSeconds).contains(_1 × 6))
            
            XCTAssert(((_1 × 3.141_59).rad ..< (_1 × 3.141_60).rad).contains((_1 × 200).gradians))
            XCTAssert(((_1 × 5.999_99).gradians.inGradians ..< (_1 × 6.000_01).gradians.inGradians).contains(_1 × 6))
            
            variable = _1.rad
            variable += _1.rad
            XCTAssert(variable == (_1 × 2).rad)
            
            variable = _1.rad
            variable −= _1.rad
            XCTAssert(variable == Angle<N>._0)
            
            variable = _1.rad
            variable−=
            XCTAssert(variable == (−_1).rad)
            
            XCTAssert(|(−_1.rad)| == _1.rad)
            variable = (_1.rad)
            variable.formAbsoluteValue()
            XCTAssert(variable == _1.rad)
            
            XCTAssert(_1.rad × 2 == (_1 × 2).rad)
            XCTAssert(4 × _1.rad == (_1 × 4).rad)
            XCTAssert(((_1 × 1.999_99) ..< (_1 × 2.000_01)).contains(_1.rad ÷ (_1 ÷ 2).rad))
            XCTAssert((_1 × 3).rad.dividedAccordingToEuclid(by: (_1 × 2).rad) == 1)
            XCTAssert((_1 × 2).rad.isDivisible(by: _1.rad))
            let _1_5 = gcd((_1 × 1.5).rad, (_1 × 3).rad)
            let _1_5b = gcd((_1 × 3).rad, (_1 × 1.5).rad)
            XCTAssert(((_1 × 1.499_99).rad ..< (_1 × 1.500_01).rad).contains(_1_5))
            XCTAssert(_1_5 == _1_5b)
            XCTAssert(((_1 × 1.499_99).rad ..< (_1 × 1.500_01).rad).contains(lcm((_1 × 1.5).rad, (_1 × 0.5).rad)))
            
            XCTAssert(_1.rad.rounded(.down, toMultipleOf: _1.rad × 2) == _1.rad × 0)
            
            XCTAssert(_1.rad.isPositive)
            XCTAssert((−_1).rad.isNegative)
            XCTAssert(Angle<N>._0.isNonPositive)
            XCTAssert(Angle<N>._0.isNonNegative)
            
            for _ in 1 ..< 100 {
                let random = Angle(randomInRange: N._0.rad ..< _1.rad)
                XCTAssert((N._0.rad ..< _1.rad).contains(random))
                let random2 = Angle(randomInRange: N._0.rad ... _1.rad)
                XCTAssert((N._0.rad ... _1.rad).contains(random2))
            }
        }
        runTests(Double.self)
        runTests(Float80.self)
        runTests(Float.self)
        runTests(RealArithmeticExample.self)
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
            value ≤= entry
        }
        XCTAssert(value == 1)
        
        for entry in list {
            value ≥= entry
        }
        XCTAssert(value == 5)
    }
    
    func testDouble() {
        // swiftlint:disable disjunction
        #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
        // swiftlint:enable disjunction
            
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
        
        func runTests<N: IntegralArithmetic>(_ type: N.Type) {
            let minusOne: N = −1
            let one: N = 1
            let two: N = 2
            let three: N = 3
            
            XCTAssert(minusOne.isNonPositive)
            XCTAssert(minusOne.isNegative)
            
            XCTAssert(|minusOne| == one)
            /* Swift.AbsoluteValuable */ XCTAssert(abs(minusOne) == one)
            
            XCTAssert(−one == minusOne)
            // swiftlint:disable ascii_hyphen_minus
            /* Swift.SignedNumber */ XCTAssert(-one == minusOne)
            /* Swift.SignedNumber */ XCTAssert(one - minusOne == two)
            // swiftlint:enable ascii_hyphen_minus
            
            XCTAssert(three.dividedAccordingToEuclid(by: −two) == −two)
            XCTAssert((−three).dividedAccordingToEuclid(by: two) == −two)
            XCTAssert(gcd(one × −12, −8) == 4)
            
            for _ in 1 ... 100 {
                XCTAssert((3 ... 7).contains(N(randomInRange: 3 ... 7)))
            }
            
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
        runTests(RealArithmeticExample.self)
        
        func runStrideableTests<N: IntegralArithmetic>(_ type: N.Type) where N : Strideable, N.Stride == N {
            let _1: N = 1
            XCTAssert(_1.advanced(by: 1) == _1 + 1)
            
            XCTAssert(N._0.distance(to: _1) == _1)
        }
        runStrideableTests(Int.self)
        runStrideableTests(Double.self)
        runStrideableTests(Float.self)
        runStrideableTests(RealArithmeticExample.self)
    }
    
    func testNegatable() {
        func runTests<N: Negatable>(_ type: N.Type, value: N, inverse: N) {
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
        runTests(Float80.self, value: 1, inverse: −1)
        runTests(Float.self, value: 1, inverse: −1)
        runTests(NegatableExample.self, value: NegatableExample(1), inverse: NegatableExample(−1))
    }
    
    func testOneDimensionalPoint() {
        
        var x = 1
        x.decrement()
        XCTAssert(x == 0)
        
        func runStrideableTests<N: OneDimensionalPoint>(start: N, end: N, vector: N.Vector) where N : Strideable, N.Vector == N.Stride {
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
        func runTests<P: PointType>(start: P, distance: P.Vector, end: P) {
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
        runTests(start: PointTypeExample(0), distance: 3, end: PointTypeExample(3))
    }
    
    func testRandomizer() {
        func runTests<R: Randomizer>(_ randomizer: R) {
            
            var UInt64sReturned: Set<UInt64> = []
            var Int64sReturned: Set<Int64> = []
            var positiveInt64sReturned: Set<Int64> = []
            
            for _ in 1 ... 100 {
                let random = randomizer.randomNumber(inRange: 1 ... 6)
                UInt64sReturned.insert(random)
                XCTAssert(1 ≤ random ∧ random ≤ 6)
                
                let randomInt = Int64(randomInRange: −3 ... 3)
                Int64sReturned.insert(randomInt)
                XCTAssert(−3 ≤ randomInt ∧ randomInt ≤ 3)
                
                let randomPositiveInt = Int64(randomInRange: 1 ... 6)
                positiveInt64sReturned.insert(randomPositiveInt)
                XCTAssert(1 ≤ randomPositiveInt ∧ randomPositiveInt ≤ 6)
                
                let randomDouble = Double(randomInRange: −3 ... 3)
                XCTAssert(−3 ≤ randomDouble ∧ randomDouble ≤ 3)
            }
            
            if R.self == PseudorandomNumberGenerator.self {
                XCTAssert(UInt64sReturned.count == 6)
                XCTAssert(Int64sReturned.count == 7)
                XCTAssert(positiveInt64sReturned.count == 6)
            }
        }
        runTests(CyclicalNumberGenerator([0, 1, 6, 7, 11, 12, UInt64.max]))
        runTests(PseudorandomNumberGenerator.defaultGenerator)
    }
    
    func testRationalArithmetic() {
        func runTests<N: RationalArithmetic>(_ type: N.Type) {
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
            
            for _ in 1 ..< 100 {
                let random = N(randomInRange: 0 ..< 1)
                XCTAssert((0 ..< 1).contains(random))
            }
        }
        runTests(Double.self)
        runTests(Float80.self)
        runTests(Float.self)
        runTests(RationalNumberTypeExample.self)
        runTests(RealArithmeticExample.self)
        
        // Previous Bugs
        
        let _ = Double(1) ÷ Double(1)
    }
    
    func testRealArithmetic() {
        func runTests<N: RealArithmetic>(_ type: N.Type) {
            let _1: N = 1
            var variable: N = 0
            
            XCTAssert((3.141_59 ..< 3.141_60).contains(N.π))
            XCTAssert(N.π == π())
            XCTAssert(N.π == N.π.π)
            
            XCTAssert((6.283_18 ..< 6.283_19).contains(N.τ))
            XCTAssert(N.τ == τ())
            XCTAssert(N.τ == N.τ.τ)
            
            XCTAssert((2.718_28 ..< 2.718_29).contains(N.e))
            XCTAssert(N.e == e())
            XCTAssert(N.e == N.e.e)
            
            XCTAssert((1.414_21 ..< 1.414_22).contains(√(_1 × 2)))
            XCTAssert((2.999_99 ..< 3.000_01).contains(4 √ (_1 × 81)))
            XCTAssert((2.999_99 ..< 3.000_01).contains(3 √ (_1 × 27)))
            variable = 1
            variable√=
            XCTAssert(variable == 1)
            
            XCTAssert((0.499_99 ..< 0.500_01).contains(log(toBase: 9, of: 3 × _1)))
            XCTAssert((0.999_99 ..< 1.000_01).contains(log(_1 × 10)))
            XCTAssert((0.693_14 ..< 0.693_15).contains(ln(_1 × 2)))
            XCTAssert((4.382_02 ..< 4.382_03).contains(ln(_1 × 80)))
            
            XCTAssert((0.479_42 ..< 0.479_43).contains(sin(_1.rad ÷ 2)))
            XCTAssert((0.017_45 ..< 0.017_46).contains(sin(_1°)))
            XCTAssert((0.944_95 ..< 0.944_96).contains(cos(_1.rad ÷ 3)))
            XCTAssert((−1.000_01 ..< −0.999_99).contains(cos(_1.rad × −π())))
            XCTAssert((−3.380_52 ..< −3.380_51).contains(tan(_1.rad × 5)))
            XCTAssert((1.188_39 ..< 1.188_40).contains(csc(_1.rad)))
            XCTAssert((−2.403_00 ..< −2.402_99).contains(sec(_1.rad × 2)))
            XCTAssert((−7.015_26 ..< −7.015_25).contains(cot(_1.rad × 3)))
            
            XCTAssert(((0.167_44 as N).rad ..< (0.167_45 as N).rad).contains(arcsin(_1 ÷ 6)))
            XCTAssert(((1.427_44 as N).rad ..< (1.427_45 as N).rad).contains(arccos(_1 ÷ 7)))
            XCTAssert(((0.463_64 as N).rad ..< (0.463_65 as N).rad).contains(arctan(_1 ÷ 2)))
            XCTAssert(((1.107_14 as N).rad ..< (1.107_15 as N).rad).contains(arctan(_1 × 2)))
            XCTAssert(((0.339_83 as N).rad ..< (0.339_84 as N).rad).contains(arccsc(_1 × 3)))
            XCTAssert(((1.318_11 as N).rad ..< (1.318_12 as N).rad).contains(arcsec(_1 × 4)))
            XCTAssert(((0.197_39 as N).rad ..< (0.197_40 as N).rad).contains(arccot(_1 × 5)))
            XCTAssert(((2.677_94 as N).rad ..< (2.677_95 as N).rad).contains(arccot(_1 × −2)))
        }
        runTests(Double.self)
        runTests(Float80.self)
        runTests(Float.self)
        runTests(RealArithmeticExample.self)
    }
    
    func testSubtractable() {
        
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
        let _: Float80 = 3 − 2
        let _: Float = 3 − 2
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
        func runTests<N: WholeArithmetic>(_ type: N.Type) {
            let zero: N = 0
            let one: N = 1
            let two: N = 2
            let three: N = 3
            
            var variable = zero
            
            XCTAssert(zero == _0())
            XCTAssert(zero == one._0)
            
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
            
            XCTAssert(two.isANaturalNumber)
            XCTAssert(one.isAnInteger)
            XCTAssert(two.isEven)
            XCTAssert(one.isOdd)
            
            XCTAssert(one.rounded(.down) == one)
            
            for _ in 1 ... 100 {
                XCTAssert((17 ... 28).contains(N(randomInRange: 17 ... 28)))
            }
            
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
    }
    
    static var allTests : [(String, (SDGMathematicsTests) -> () throws -> Void)] {
        return [
            ("testAngle", testAngle),
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
            ("testWholeArithmetic", testWholeArithmetic),
        ]
    }
}
