/*
 WholeNumberType.swift

 This source file is part of the SDGMathematics open source project.
 https://sdggiesbrecht.github.io/SDGMathematics/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGMathematics project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A type which *only ever* represents whole numbers.
///
/// Conformance Requirements:
///
/// - `WholeArithmetic`
public protocol WholeNumberType : WholeArithmetic {

}

private let binaryDigits: [Set<UnicodeScalar>] = [
        //    arb  pes  hi   bn   ta   my   km   th   lo
        ["0", "٠", "۰", "०", "০", "௦", "၀", "០", "๐", "໐"],
        ["1", "١", "۱", "१", "১", "௧", "၁", "១", "๑", "໑"]
    ]

private let octalDigits: [Set<UnicodeScalar>] = binaryDigits + [
        ["2", "٢", "۲", "२", "২", "௨", "၂", "២", "๒", "໒"],
        ["3", "٣", "۳", "३", "৩", "௩", "၃", "៣", "๓", "໓"],
        ["4", "٤", "۴", "४", "৪", "௪", "၄", "៤", "๔", "໔"],
        ["5", "٥", "۵", "५", "৫", "௫", "၅", "៥", "๕", "໕"],
        ["6", "٦", "۶", "६", "৬", "௬", "၆", "៦", "๖", "໖"],
        ["7", "٧", "۷", "७", "৭", "௭", "၇", "៧", "๗", "໗"]
    ]

private let decimalDigits: [Set<UnicodeScalar>] = octalDigits + [
        ["8", "٨", "۸", "८", "৮", "௮", "၈", "៨", "๘", "໘"],
        ["9", "٩", "۹", "९", "৯", "௯", "၉", "៩", "๙", "໙"]
    ]

private let hexadecimalDigits: [Set<UnicodeScalar>] = decimalDigits + [
        ["A", "a"],
        ["B", "b"],
        ["C", "c"],
        ["D", "d"],
        ["E", "e"],
        ["F", "f"]
    ]

extension WholeNumberType {

    public init(binary representation: String) {
        self.init(representation, digitSet: binaryDigits)
    }

    public init(octal representation: String) {
        self.init(representation, digitSet: octalDigits)
    }

    public init(_ representation: String) {
        self.init(representation, digitSet: decimalDigits)
    }

    public init(hexadecimal representation: String) {
        self.init(representation, digitSet: hexadecimalDigits)
    }

    public init(_ representation: String, digitSet: [Set<UnicodeScalar>]) {
        let base = Self(UIntMax(digitSet.count))
        var mapping: [UnicodeScalar: Self] = [:]
        for value in digitSet.indices {
            let characters = digitSet[value]
            for character in characters {
                assert(String(character).decomposedStringWithCompatibilityMapping == String(character), "\(character) is not in normalization form NFKD.")
                mapping[character] = Self(UIntMax(value))
            }
        }

        self = 0
        var position: Self = 0
        for character in representation.decomposedStringWithCompatibilityMapping.unicodeScalars.reversed() {
            if let digit = mapping[character] {
                self += (base ↑ position) × digit
                position += 1
            }
        }
    }
}
