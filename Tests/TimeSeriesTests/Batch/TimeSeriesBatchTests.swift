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
        let emptyBatch = TimeSeriesBatch([Series]())
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

        let batch = TimeSeriesBatch([series])

        #expect(batch.isEmpty == false)
        #expect(batch.count == 1)
        #expect(batch.timeRange == FixedDateInterval(start: FixedDate(110), end: FixedDate(110)))

        let interval = FixedDateInterval(start: FixedDate(100), end: FixedDate(400))
        let subBatch = batch[interval]

        #expect(subBatch.isEmpty == false)
        #expect(subBatch.timeRange == FixedDateInterval(start: FixedDate(110), end: FixedDate(110)))

        #expect(batch[FixedDateInterval(start: FixedDate(200), end: FixedDate(400))].isEmpty == true)
        #expect(batch[FixedDateInterval(start: FixedDate(200), end: FixedDate(400))].timeRange == nil)
    }

    @Test("Many items batch")
    func batch() {
        let series1 = Self.series1
        let series2 = Self.series2
        let series3 = Self.series3

        let batch = TimeSeriesBatch([series1, series2, series3])

        #expect(batch.isEmpty == false)
        #expect(batch.index(before: 1) == 0)
        #expect(batch.count == 3)
        #expect(batch.timeRange == FixedDateInterval(start: FixedDate(110), end: FixedDate(1150)))

        #expect(batch[0] == series1)
        #expect(batch[1] == series2)
        #expect(batch[2] == series3)
    }

    @Test("Batch slice with FixedDateInterval")
    func batchSlice() {
        let batch = TimeSeriesBatch([
            Self.series1, // 0
            Self.series2, // 1
            Self.series3, // 2
            Self.series4, // 3
            Self.series5, // 4
            Self.series6, // 5
        ])
        #expect(batch.count == 6)

        let slice = batch[1 ... 3]

        #expect(slice.count == 3)

        let expacted = TimeSeriesBatch([
            Self.series2,
            Self.series3,
            Self.series4,
        ])

        #expect(Array(slice) == Array(expacted))
    }

    @Test("Batch slice with FixedDateInterval")
    func batchSliceDateInterval() {
        let series1 = Self.series1
        let series2 = Self.series2
        let series3 = Self.series3

        let batch = TimeSeriesBatch([series1, series2, series3])
        #expect(batch.count == 3)

        #expect(batch[FixedDateInterval(start: FixedDate(90), end: FixedDate(100))].isEmpty)
        #expect(batch[FixedDateInterval(start: FixedDate(500), end: FixedDate(600))].isEmpty)
        #expect(batch[FixedDateInterval(start: FixedDate(2000), end: FixedDate(2400))].isEmpty)

        let renge = FixedDateInterval(start: FixedDate(90), end: FixedDate(250))

        let expacted = TimeSeriesBatch([series1[renge], series2[renge]])

        #expect(Array(batch[renge]) == Array(expacted))
        #expect(batch[renge].count == 2)

        let renge1 = FixedDateInterval(start: FixedDate(900), end: FixedDate(1100))
        let expacted1 = TimeSeriesBatch([series3[renge1]])

        #expect(Array(batch[renge1]) == Array(expacted1))
    }
}

private
extension TimeSeriesBatchTests {
    static let series1 = TimeSeries(timeBase: FixedDate(100),
                                    items: [
                                        MocItem(time: 10, index: 1),
                                    ])

    static let series2 = TimeSeries(timeBase: FixedDate(200),
                                    items: [
                                        MocItem(time: 10, index: 1),
                                        MocItem(time: 20, index: 2),
                                        MocItem(time: 30, index: 3),
                                        MocItem(time: 40, index: 4),
                                        MocItem(time: 50, index: 5),
                                        MocItem(time: 60, index: 6),
                                        MocItem(time: 70, index: 7),
                                        MocItem(time: 80, index: 8),
                                        MocItem(time: 90, index: 9),
                                        MocItem(time: 100, index: 10),
                                        MocItem(time: 110, index: 11),
                                    ])

    static let series3 = TimeSeries(timeBase: FixedDate(1000),
                                    items: [
                                        MocItem(time: 10, index: 1),
                                        MocItem(time: 20, index: 2),
                                        MocItem(time: 30, index: 3),
                                        MocItem(time: 40, index: 4),
                                        MocItem(time: 50, index: 5),
                                        MocItem(time: 60, index: 6),
                                        MocItem(time: 70, index: 7),
                                        MocItem(time: 80, index: 8),
                                        MocItem(time: 90, index: 9),
                                        MocItem(time: 100, index: 10),
                                        MocItem(time: 110, index: 11),
                                        MocItem(time: 120, index: 12),
                                        MocItem(time: 130, index: 13),
                                        MocItem(time: 140, index: 14),
                                        MocItem(time: 150, index: 15),
                                    ])

    static let series4 = TimeSeries(timeBase: FixedDate(2000),
                                    items: [
                                        MocItem(time: 10, index: 1),
                                    ])

    static let series5 = TimeSeries(timeBase: FixedDate(3000),
                                    items: [
                                        MocItem(time: 10, index: 1),
                                        MocItem(time: 20, index: 2),
                                        MocItem(time: 30, index: 3),
                                        MocItem(time: 40, index: 4),
                                        MocItem(time: 50, index: 5),
                                        MocItem(time: 60, index: 6),
                                        MocItem(time: 70, index: 7),
                                        MocItem(time: 80, index: 8),
                                        MocItem(time: 90, index: 9),
                                        MocItem(time: 100, index: 10),
                                        MocItem(time: 110, index: 11),
                                    ])

    static let series6 = TimeSeries(timeBase: FixedDate(4000),
                                    items: [
                                        MocItem(time: 10, index: 1),
                                        MocItem(time: 20, index: 2),
                                        MocItem(time: 30, index: 3),
                                        MocItem(time: 40, index: 4),
                                        MocItem(time: 50, index: 5),
                                        MocItem(time: 60, index: 6),
                                        MocItem(time: 70, index: 7),
                                        MocItem(time: 80, index: 8),
                                        MocItem(time: 90, index: 9),
                                        MocItem(time: 100, index: 10),
                                        MocItem(time: 110, index: 11),
                                        MocItem(time: 120, index: 12),
                                        MocItem(time: 130, index: 13),
                                        MocItem(time: 140, index: 14),
                                        MocItem(time: 150, index: 15),
                                    ])
}
