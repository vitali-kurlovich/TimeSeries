//
//  TimeSeriesCollectionTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 14.12.24.
//

import Testing
@testable import TimeSeries

enum TimeSeriesCollectionTests {
    @Suite("Date & Time")
    struct TimeSeriesCollectionDate {
        @Test("Series TimeRange")
        func timeRange() throws {
            let series = TimeSeries(timeBase: FixedDate(100),
                                    items: [
                                        MocItem(time: 10, index: 1),
                                        MocItem(time: 20, index: 2),
                                        MocItem(time: 110, index: 3),
                                        MocItem(time: 120, index: 4),
                                    ])

            #expect(series.timeRange == .init(start: FixedDate(110), end: FixedDate(220)))
            #expect(series[1 ... 2].timeRange == .init(start: FixedDate(120), end: FixedDate(210)))

            #expect(TimeSeries<MocItem>(timeBase: FixedDate(100), items: []).timeRange == nil)
        }

        @Test("Series dateTime")
        func dateTime() throws {
            let series = TimeSeries(timeBase: FixedDate(100),
                                    items: [
                                        MocItem(time: 10, index: 1),
                                        MocItem(time: 20, index: 2),
                                        MocItem(time: 30, index: 3),
                                        MocItem(time: 40, index: 4),
                                    ])[1 ... 3]

            #expect(series.dateTime(at: 1) == FixedDate(120))
            #expect(series.dateTime(at: 2) == FixedDate(130))
            #expect(series.dateTime(at: 3) == FixedDate(140))

            let normalized = series.normalized()

            #expect(normalized.dateTime(at: 0) == FixedDate(120))
            #expect(normalized.dateTime(at: 1) == FixedDate(130))
            #expect(normalized.dateTime(at: 2) == FixedDate(140))
        }
    }

    @Suite("Find")
    struct TimeSeriesCollectionFind {
        @Test("First Index withTimeGreaterThan")
        func firstIndex() throws {
            let series = TimeSeries(timeBase: FixedDate(100),
                                    items: [
                                        MocItem(time: 10, index: 1), // 0
                                        MocItem(time: 20, index: 2), // 1
                                        MocItem(time: 30, index: 3), // 2
                                        MocItem(time: 40, index: 4), // 3
                                    ])

            #expect(series.firstIndex(withTimeGreaterThan: 5) == 0)
            #expect(series.firstIndex(withTimeGreaterThan: 10) == 1)
            #expect(series.firstIndex(withTimeGreaterThan: 15) == 1)
            #expect(series.firstIndex(withTimeGreaterThan: 20) == 2)
            #expect(series.firstIndex(withTimeGreaterThan: 25) == 2)
            #expect(series.firstIndex(withTimeGreaterThan: 30) == 3)
            #expect(series.firstIndex(withTimeGreaterThan: 35) == 3)
            #expect(series.firstIndex(withTimeGreaterThan: 40) == 4)
        }
    }

    @Suite("TimeSeries Slice")
    struct TimeSeriesCollectionSlice {
        @Test("Empty TimeSeries Sliecing")
        func sliceEmptySeries() throws {
            let series = TimeSeriesSlice<MocItem>.empty
            let interval = FixedDateInterval(start: FixedDate(100), end: FixedDate(200))
            #expect(series[interval] == .empty)
        }

        @Test("TimeSeries Sliecing")
        func sliceSeries() throws {
            let series = TimeSeries(timeBase: FixedDate(100),
                                    items: [
                                        MocItem(time: 10, index: 1), // 0
                                        MocItem(time: 20, index: 2), // 1
                                        MocItem(time: 30, index: 3), // 2
                                        MocItem(time: 40, index: 4), // 3
                                    ])

            let beforeInterval = FixedDateInterval(start: FixedDate(10), end: FixedDate(90))

            #expect(series[beforeInterval] == .empty)

            let afterInterval = FixedDateInterval(start: FixedDate(141), end: FixedDate(200))

            #expect(series[afterInterval] == .empty)

            let intervalAll = FixedDateInterval(start: FixedDate(90), end: FixedDate(200))

            #expect(series[intervalAll] == series[0 ... 3])

            #expect(series[0 ... 3][1 ... 2] == series[1 ... 2])

            let intervalAllFit = FixedDateInterval(start: FixedDate(110), end: FixedDate(140))

            #expect(series[intervalAllFit] == series[0 ... 3])
            #expect(series[FixedDateInterval(start: FixedDate(100), end: FixedDate(140))] == series[0 ... 3])
            #expect(series[FixedDateInterval(start: FixedDate(110), end: FixedDate(150))] == series[0 ... 3])
            #expect(series[FixedDateInterval(start: FixedDate(111), end: FixedDate(139))] == series[1 ... 2])
        }
    }
}
