//
//  TimeSeriesBatchTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 15.12.24.
//

import Testing
import TimeSeries

struct TimeSeriesBatchTests {
    typealias Series = TimeSeries<MocItem>

    @Test("Empty batch")
    func empty() {
        let emptyBatch = TimeSeriesBatch<Series>([])
        #expect(emptyBatch.isEmpty)
        #expect(emptyBatch.timeRange == nil)

        let interval = FixedDateInterval(start: FixedDate(200), end: FixedDate(400))
        let subBatch = emptyBatch[interval]

        #expect(subBatch.isEmpty)
        #expect(subBatch.timeRange == nil)
    }
}

/*
 let series = TimeSeries(timeBase: FixedDate(100),
                         items: [
                             MocItem(time: 10, index: 1),
                             MocItem(time: 20, index: 2),
                             MocItem(time: 30, index: 3),
                             MocItem(time: 40, index: 4),
                         ])

 */
