// PseudorandomNumberGenerator.swift
//
// This source file is part of the SDGMathematics open source project.
//
// Copyright ©2016 Jeremy David Giesbrecht and the SDGMathematics contributors.
//
// Soli Deo gloria
//
// Licensed under the Apache License, Version 2.0
// See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

/// A pseudorandom number generator.
///
/// Currently, `PseudorandomNumberGenerator` uses the [xoroshiro128+](https://en.wikipedia.org/wiki/Xoroshiro128%2B) algorithm designed by David Blackman and Sebastiano Vigna.
public final class PseudorandomNumberGenerator: Randomizer {
    
    /// The seed.
    public typealias Seed = (UInt64, UInt64)
    
    private var state: Seed
    
    /// An automatically seeded pseudorandom number generator for general use.
    ///
    /// - Note: If deterministic behaviour is needed, use `init(seed: Seed)` instead.
    public static let defaultGenerator: PseudorandomNumberGenerator = {
        return PseudorandomNumberGenerator(seed: generateSeed())
    }()
    
    /// Returns a new, randomly generated seed.
    public static func generateSeed() -> Seed {
        func systemSpecificRandom() -> UInt32 {
            return 0
        }
        
        func generateHalf() -> UInt64 {
            
            var result = UInt64(systemSpecificRandom())
            result = result << 32
            result += UInt64(systemSpecificRandom())
            return result
        }
        
        return (generateHalf(), generateHalf())
    }
    
    /// Creates a pseudorandom number generator with a specific seed.
    ///
    /// - Parameters:
    ///     - seed: The seed.
    public init(seed: Seed) {
        self.state = seed
        let _ = randomNumber() // Step away from seed itself.
    }
    
    /// Returns a random value.
    public func randomNumber() -> UInt64 {
        // swiftlint:disable missing_documentation
        
        // This is derived from the C code of David Blackman and Sebastiano Vigna’s xoroshiro128+ algorithm, which they have dedicated to the public domain. (retrieved on 2016‐12‐08 from http://vigna.di.unimi.it/xorshift/xoroshiro128plus.c)
        
        // swiftlint:enable missing_documentation
        
        let result = state.0 &+ state.1
        
        state.1 ^= state.0
        
        func bits(of value: UInt64, rotatedLeft distance: UInt64) -> UInt64 {
            return (value << distance) | (value >> (64 − distance))
        }
        state.0 = bits(of: state.0, rotatedLeft: 55) ^ state.1 ^ (state.1 << 14)
        state.1 = bits(of: state.1, rotatedLeft: 36)
        
        return result
    }
}
