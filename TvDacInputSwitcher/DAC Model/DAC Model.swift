//  Model.swift
//  RME MIDI

import Foundation
import SwiftMIDIIO

struct DacModel  {
    static var shared = DacModel()
    let mgr: MIDIManager
    var outputConn: MIDIOutputConnection
    var outputPoints: [MIDIOutputEndpoint]
    
    init() {
        mgr = MIDIManager(clientName: "", model: "", manufacturer: "")
        do {
            try mgr.start()
        } catch {
            print("Error while starting MIDI manager: \(error)")
        }
        do {
            try mgr.addOutputConnection(to: .allInputs, tag: "AllOutputConnections", filter: MIDIEndpointFilter(owned: false))
        } catch {
            print("Error adding output connection: \(error)")
        }
        outputConn = mgr.managedOutputConnections["AllOutputConnections"]!
        outputPoints = mgr.endpoints.outputsUnowned
        print("DacModel initialized (bob)")
        print(outputPoints.count)
        print(outputPoints[0].displayName) // ADI-2 DAC (54695070) Port 1
    }
    
    // MARK: OUTPUT connection to send to Input endpoint(s):
//                let newInputs = points.inputsUnowned // Unowned = External.
//                if newInputs.count == 0 {
//                    print("No newInputs")
//                    self.volumeReceived = false
//    //                self.volumeTxt = ""
//                } else {
//                    print("newInputs = \(newInputs[0].displayName)")
//                }
//                guard let rmeInputEndpoint = newInputs.first(where: { $0.displayName.contains("ADI-2")})
//                else {
//                    print("No RME Input endpoint found.")
//                    return
//                }
//                let rmeInputIdentity = MIDIEndpointIdentity.uniqueID(rmeInputEndpoint.uniqueID)
//                var rmeInputSet = Set<MIDIEndpointIdentity>()
//                rmeInputSet.update(with: rmeInputIdentity)
//                try! self.mgr.addOutputConnection(to: .inputs(matching: rmeInputSet), tag: "Tx")
    
}
