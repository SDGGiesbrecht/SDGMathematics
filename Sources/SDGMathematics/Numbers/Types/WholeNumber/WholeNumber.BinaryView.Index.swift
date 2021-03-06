/*
 WholeNumber.BinaryView.Index.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension WholeNumberBinaryView {

    internal struct Index : Comparable, Equatable, OneDimensionalPoint {

        // MARK: - Properties

        internal typealias DigitIndex = Array<WholeNumber.Digit>.Index
        internal var digit: DigitIndex

        internal typealias BitIndex = SDGMathematics.BinaryView<WholeNumber.Digit>.Index
        internal var bit: BitIndex

        // MARK: - Comparable

        internal static func < (lhs: Index, rhs: Index) -> Bool {
            return (lhs.digit, lhs.bit) < (rhs.digit, rhs.bit)
        }

        // MARK: - Equatable

        internal static func == (lhs: Index, rhs: Index) -> Bool {
            return (lhs.digit, lhs.bit) == (rhs.digit, rhs.bit)
        }

        // MARK: - PointType

        internal typealias Vector = WholeNumber.BinaryView.IndexDistance

        internal static func += (lhs: inout Index, rhs: Vector) {
            lhs.digit += rhs.digitDistance
            var bit = IntMax(lhs.bit)
            bit += rhs.bitDistance

            let base = IntMax(SDGMathematics.BinaryView<WholeNumber.Digit>.count)
            if bit ≥ base {
                lhs.digit += 1
                bit −= base
            }
            if bit < 0 {
                lhs.digit −= 1
                bit += base
            }
            lhs.bit = BitIndex(bit)
        }

        internal static func − (lhs: Index, rhs: Index) -> Vector {
            var bitDistance = lhs.bit − rhs.bit
            var digitDistance = lhs.digit − rhs.digit
            if bitDistance.isNegative {
                bitDistance += SDGMathematics.BinaryView<WholeNumber.Digit>.count
                digitDistance −= 1
            }
            return IndexDistance(digitDistance: digitDistance, bitDistance: bitDistance)
        }

        // MARK: - Strideable

        internal typealias Stride = Vector
    }
}
