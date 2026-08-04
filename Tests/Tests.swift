//  Tests.swift

import Testing
// @testable import CLICommand
internal import ArgumentParser

struct Tests {

    @Test func tv() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let dac = DacModel()
        dac.sendEvent(analogPortAddress: 12, parameterID: 1, rawValue: 2)
    }

    @Test func mac() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let dac = DacModel()
        dac.sendEvent(analogPortAddress: 12, parameterID: 1, rawValue: 3)
    }
}
