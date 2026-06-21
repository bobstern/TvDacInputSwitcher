//  main.swift
//  TV-DAC-input-switch

import Foundation
import ArgumentParser
import SwiftMIDIIO

struct SwitchInputs: @preconcurrency ParsableCommand {
    @Flag()
    var tv = false // CLI prefix = 2 hyphens cuz >1 character.
    @Flag()
    var mac = false

    @MainActor func run() {
        
        if tv {
            print("Switching to TV") // Prints to Console.
            DacModel.shared.sendEvent(analogPortAddress: 3, parameterID: 1, rawValue: 2)
        }
        if mac {
            print("Switching to Mac")
            DacModel.shared.sendEvent(analogPortAddress: 3, parameterID: 1, rawValue: 3)
        }
    }
}

SwitchInputs.main()
