//
//  ModelUtility.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/19/20.
//

import Foundation

func randomNumber(probabilities: [Double]) -> Int {

    // Sum of all probabilities (so that we don't have to require that the sum is 1.0):
    let sum = probabilities.reduce(0, +)
    // Random number in the range 0.0 <= rnd < sum :
    let rnd = Double.random(in: 0.0 ..< sum)
    // Find the first interval of accumulated probabilities into which `rnd` falls:
    var accum = 0.0
    for (i, p) in probabilities.enumerated() {
        accum += p
        if rnd < accum {
            return i
        }
    }
    // This point might be reached due to floating point inaccuracies:
    return (probabilities.count - 1)
}

func convertBoolToInt(_ boolean: Bool) -> Int {
    return boolean ? 1 : 0
}

func convertBoolToDouble(_ boolean: Bool) -> Double {
    return boolean ? 1.0 : 0.0
}
