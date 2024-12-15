//
//  FixedDateTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 14.12.24.
//

import Testing
@testable import TimeSeries

struct FixedDateTests {
    @Test("FixedDate adding")
    func adding() throws {
        let fixedData = FixedDate(200)

        #expect(fixedData.adding(milliseconds: Int16(200)) == FixedDate(400))
        #expect(fixedData.adding(milliseconds: UInt16(200)) == FixedDate(400))
        #expect(fixedData.adding(milliseconds: Int32(200)) == FixedDate(400))
        #expect(fixedData.adding(milliseconds: UInt32(200)) == FixedDate(400))
        #expect(fixedData.adding(milliseconds: Int64(200)) == FixedDate(400))
        #expect(fixedData.adding(milliseconds: UInt64(200)) == FixedDate(400))

        #expect(fixedData.adding(milliseconds: Int(200)) == FixedDate(400))
        #expect(fixedData.adding(milliseconds: UInt(200)) == FixedDate(400))
    }
}
