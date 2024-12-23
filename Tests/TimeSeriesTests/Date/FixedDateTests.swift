//
//  FixedDateTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 14.12.24.
//

import Foundation
import Testing
@testable import TimeSeries

struct FixedDateTests {
    @Test("FixedDate with timeIntervalSince1970")
    func dateWithTimeInterval() throws {
        let result = FixedDate(timeIntervalSince1970: 1_000_000.0)
        #expect(result == FixedDate(1_000_000_000))
    }

    @Test("FixedDate with Date")
    func fixedDateFromDate() throws {
        let date = Date(timeIntervalSince1970: 1_000_000.0)

        let result = FixedDate(date)
        #expect(result == FixedDate(1_000_000_000))
    }

    @Test("timeIntervalSince1970")
    func timeIntervalSince1970() throws {
        #expect(FixedDate(1_000_000_000).timeIntervalSince1970 == 1_000_000.0)
    }

    @Test("FixedDate with Date")
    func dateFromFixedDate() throws {
        let date = Date(FixedDate(1_000_000_000))
        let expected = Date(timeIntervalSince1970: 1_000_000.0)
        #expect(date == expected)
    }

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
