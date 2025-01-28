//
//  TimeSeriesCollectionTests+Normalized.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 28.01.25.
//

import Testing
import TimeSeries

extension TimeSeriesCollectionTests {
    @Suite("Normalized")
    struct TimeSeriesCollectionNormalized {
        @Test("Normalized empty")
        func normalized() {
            let empty = TimeSeries<MocItem>(timeBase: FixedDate(200), items: [])
            #expect(empty.normalized() == empty)
        }

        @Test("Normalized one items series", arguments: [
            (series: TimeSeries<MocItem>(timeBase: FixedDate(200), items: [.init(time: 0, index: 0)]),
             expected: TimeSeries<MocItem>(timeBase: FixedDate(200), items: [.init(time: 0, index: 0)])),

            (series: TimeSeries<MocItem>(timeBase: FixedDate(200), items: [.init(time: 100, index: 0)]),
             expected: TimeSeries<MocItem>(timeBase: FixedDate(300), items: [.init(time: 0, index: 0)])),

            (series: TimeSeries<MocItem>(timeBase: FixedDate(0), items: [.init(time: 100, index: 0)]),
             expected: TimeSeries<MocItem>(timeBase: FixedDate(100), items: [.init(time: 0, index: 0)])),
        ])
        func normalizedOne(
            _ test: (series: TimeSeries<MocItem>, expected: TimeSeries<MocItem>)
        ) {
            #expect(test.series.normalized() == test.expected)
        }

        @Test("Normalized series", arguments: [
            (series: TimeSeries<MocItem>(timeBase: FixedDate(200), items: [
                MocItem(time: 0, index: 0),
                MocItem(time: 100, index: 1),
                MocItem(time: 200, index: 2),
            ]),
            expected: TimeSeries<MocItem>(timeBase: FixedDate(200), items: [
                MocItem(time: 0, index: 0),
                MocItem(time: 100, index: 1),
                MocItem(time: 200, index: 2),
            ])),

            (series: TimeSeries<MocItem>(timeBase: FixedDate(200), items: [
                MocItem(time: 100, index: 0),
                MocItem(time: 150, index: 1),
                MocItem(time: 200, index: 2),
            ]),
            expected: TimeSeries<MocItem>(timeBase: FixedDate(300), items: [
                MocItem(time: 0, index: 0),
                MocItem(time: 50, index: 1),
                MocItem(time: 100, index: 2),
            ])),

            (series: TimeSeries<MocItem>(timeBase: FixedDate(0), items: [MocItem(time: 100, index: 0)]),
             expected: TimeSeries<MocItem>(timeBase: FixedDate(100), items: [MocItem(time: 0, index: 0)])),
        ])
        func normalized(
            _ test: (series: TimeSeries<MocItem>, expected: TimeSeries<MocItem>)
        ) {
            #expect(test.series.normalized() == test.expected)
        }

        @Test("Normalized series slice", arguments: [
            (series: TimeSeries<MocItem>(timeBase: FixedDate(200), items: [
                MocItem(time: 0, index: 0),
                MocItem(time: 100, index: 1),
                MocItem(time: 200, index: 2),
            ])[1 ..< 3],
            expected: TimeSeriesSlice<MocItem>(timeBase: FixedDate(300), items: [
                MocItem(time: 0, index: 1),
                MocItem(time: 100, index: 2),
            ])),

            (series: TimeSeries<MocItem>(timeBase: FixedDate(200), items: [
                MocItem(time: -100, index: 0),
                MocItem(time: 200, index: 1),
                MocItem(time: 300, index: 2),
            ])[1 ..< 3],
            expected: TimeSeriesSlice<MocItem>(timeBase: FixedDate(400), items: [
                MocItem(time: 0, index: 1),
                MocItem(time: 100, index: 2),
            ])),

        ])
        func normalized(
            _ test: (series: TimeSeriesSlice<MocItem>, expected: TimeSeriesSlice<MocItem>)
        ) {
            #expect(test.series.normalized() == test.expected)
        }
    }
}
