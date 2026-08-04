//
//  SwitchInputs.swift
//  TvDacInputSwitcher
//
//  Created by bob on 8/3/26.
//


import Foundation
import ArgumentParser
import SwiftMIDIIO

// let dac = DacModel()

struct CLICommand: @preconcurrency ParsableCommand {
    @Flag()
    var tv = false // CLI prefix = 2 hyphens cuz >1 character.
    @Flag()
    var mac = false

    @MainActor func run() {
        
        let dac = DacModel()  // cf analogPort = 12 ??
        
        if tv { 
            print("Switching to TV") // Prints to Console.
            // set DAC input to Optical:
            dac.sendEvent(analogPortAddress: 3, parameterID: 1, rawValue: 2)
        }
        
        if mac {
            print("Switching to Mac")
            // set DAC input to USB:
            dac.sendEvent(analogPortAddress: 3, parameterID: 1, rawValue: 3)
        }
    }
}
