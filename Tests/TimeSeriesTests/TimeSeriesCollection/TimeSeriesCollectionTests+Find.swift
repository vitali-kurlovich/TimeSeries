//
//  TimeSeriesCollectionTests+Find.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 24.01.25.
//

import Testing
@testable import TimeSeries

extension TimeSeriesCollectionTests {
    @Suite("Find index")
    struct TimeSeriesCollectionFindIndex {
        private var series: TimeSeries<MocItem> {
            TimeSeries(timeBase: FixedDate(100),
                       items: [
                           MocItem(time: 10, index: 1), // 0
                           MocItem(time: 20, index: 2), // 1
                           MocItem(time: 30, index: 3), // 2
                           MocItem(time: 40, index: 4), // 3
                       ])
        }

        @Test("First Index withTimeOffsetGreaterThan",
              arguments: [
            (offset: 5, index: 0),
            (offset: 10, index: 1),
            (offset: 15, index: 1),
            (offset: 20, index: 2),
            (offset: 25, index: 2),
            (offset: 30, index: 3),
            (offset: 35, index: 3),
            (offset: 40, index: 4),
            (offset: 45, index: 4),

        ])
        func firstIndexGreaterThan(_ testData: (offset: Int16, index: Int)) throws {
            #expect(series.firstIndex(withTimeOffsetGreaterThan: testData.offset) == testData.index)
        }

        @Test("First Index withTimeOffsetGreaterThan",
              arguments: [
            (offset: 5, index: 0),
            (offset: 10, index: 0),
            (offset: 15, index: 1),
            (offset: 20, index: 1),
            (offset: 25, index: 2),
            (offset: 30, index: 2),
            (offset: 35, index: 3),
            (offset: 40, index: 3),
            (offset: 45, index: 4),

        ])
        func firstIndexGreaterOrEqualThan(_ testData: (offset: Int16, index: Int)) throws {
            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: testData.offset) == testData.index)
        }
    }
}
