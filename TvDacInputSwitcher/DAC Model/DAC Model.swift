//  Model.swift
//  RME MIDI

import Foundation
import SwiftMIDIIO

// all MIDIManager commands used to send commands to DAC are synchronous.
class DacModel  {
    let mgr: MIDIManager
    var outputConn: MIDIOutputConnection
    
    init() {
        mgr = MIDIManager(clientName: "", model: "", manufacturer: "")
        // Never throws error, even if no MIDI devices:
        try! mgr.start()
        try! mgr.addOutputConnection(to: .allInputs, tag: "AllOutputConnections", filter: MIDIEndpointFilter(owned: false))
        outputConn = mgr.managedOutputConnections["AllOutputConnections"]!
        
        // outputPoints used only to test presence of DAC, not for communication:
        let outputPoints: [MIDIOutputEndpoint] = mgr.endpoints.outputsUnowned
        guard outputPoints.count > 0 else {
            print("DAC missing!  (bob)")
            exit(0)
        }
        print(outputPoints[0].displayName) // ADI-2 DAC (54695070) Port 1
    }
    
}
