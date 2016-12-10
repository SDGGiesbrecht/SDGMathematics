// IntegralArithmetic.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

/// A type that can be used for integral arithmetic.
///
/// Conformance Requirements:
///
/// - `WholeArithmetic`
/// - `Negatable`
public protocol IntegralArithmetic: AbsoluteValuable /* requires negatability */, Negatable, SignedNumber, WholeArithmetic {
    
}
