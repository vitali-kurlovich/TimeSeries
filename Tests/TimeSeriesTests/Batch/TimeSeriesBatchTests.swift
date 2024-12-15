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

    @Test("One item batch")
    func one() {
        let series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                ])

        let batch = TimeSeriesBatch(CollectionOfOne(series))

        #expect(batch.isEmpty == false)
        #expect(batch.timeRange == FixedDateInterval(start: FixedDate(110), end: FixedDate(110)))

        let interval = FixedDateInterval(start: FixedDate(100), end: FixedDate(400))
        let subBatch = batch[interval]

        #expect(subBatch.isEmpty == false)
        #expect(subBatch.timeRange == FixedDateInterval(start: FixedDate(110), end: FixedDate(110)))

        #expect(batch[FixedDateInterval(start: FixedDate(200), end: FixedDate(400))].isEmpty == true)
        #expect(batch[FixedDateInterval(start: FixedDate(200), end: FixedDate(400))].timeRange == nil)
    }
}
