//
//  Send Event.swift
//  RME MIDI
//
//  Created by bob on 10/18/24.

import Foundation
import SwiftMIDIIO

extension DacModel {

    mutating func sendEvent(analogPortAddress: Int, parameterID: Int, rawValue: Int) {
        // analogPortAddress for Line Out:
        // 3 All but EQ, 4 EQ Left & Bass/Treble, 5 EQ Right.
        
//        guard let outConnection = mgr.managedOutputConnections["Tx"] else {return}
        
        let attribLow2 = UInt8(parameterID) & 3
        let attribHigh3 = UInt8(parameterID) >> 2

        let valueLow7 = rawValue & ((1<<7)-1)  // 2^7=128.
        let valueHigh5 = (rawValue >> 7) & ((1<<5)-1) // Mask upper 1's cuz negative. 2^5=64.

        let byte1 = (UInt8(analogPortAddress) << 3) + attribHigh3
        let byte2 = (attribLow2 << 5) | UInt8(valueHigh5)
        let byte3 = UInt8(valueLow7)
        
        // MARK: Send Event Syntax
        // 0x71 = ADI-2 DAC model.
        // 0x02 = Send parameters to DAC.
        // Trailing F7 omitted from argument per MIDIKit docs.
        let event7 = try! MIDIEvent.sysEx7(manufacturer: .threeByte(byte2: 0x20, byte3: 0x0d), data: [0x71, 0x02, byte1, byte2, byte3])
        
        outputConn = self.mgr.managedOutputConnections["AllOutputConnections"]!
        try! outputConn.send(event: event7)
    }
    
//    func getAllSettings() async {
//        repeat {
//            // guard never fails. Connection succeeds immediately after DAC powered up:
//            guard let outConnection = mgr.managedOutputConnections["Tx"] else {
//                print("Get All Settings: Tx Connection Failed in Repeat Loop.")
//                try! await Task.sleep(for: .seconds(1))
//                continue
//            }
//            print("Get All Settings: Tx Connection found in Repeat loop.")
//            let event7 = try! MIDIEvent.sysEx7(manufacturer: .threeByte(byte2: 0x20, byte3: 0x0d), data: [0x71, 0x03, 0x09])
//            try! outConnection.send(event: event7)
//            // When DAC powered on, Mac immediately recognizes the new endpoint and successfully
//            // adds input and output connections to Managed Connections dict, but additional
//            // 6-7 seconds reqd for DAC to boot so it can respond to the Get All Settings cmd.
//            try! await Task.sleep(for: .seconds(1))
//        } while self.volumeReceived == false
//    }
    
}
