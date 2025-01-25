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

    @Suite("TimeSeries setTimeBase")
    struct TimeSeriesTimeBase {
        @Test("TimeSeries setTimeBase", arguments: [
            (series: TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                    MocItem(time: 20, index: 2),
                                    MocItem(time: 30, index: 3),
                                    MocItem(time: 40, index: 4),
                                ]),
             timeBase: FixedDate(100),
             expected: TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 10, index: 1),
                                      MocItem(time: 20, index: 2),
                                      MocItem(time: 30, index: 3),
                                      MocItem(time: 40, index: 4),
                                  ])),

            (series: TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                    MocItem(time: 20, index: 2),
                                    MocItem(time: 30, index: 3),
                                    MocItem(time: 40, index: 4),
                                ]),
             timeBase: FixedDate(50),
             expected: TimeSeries(timeBase: FixedDate(50),
                                  items: [
                                      MocItem(time: 60, index: 1),
                                      MocItem(time: 70, index: 2),
                                      MocItem(time: 80, index: 3),
                                      MocItem(time: 90, index: 4),
                                  ])),

            (series: TimeSeries(timeBase: FixedDate(100), items: []),
             timeBase: FixedDate(50),
             expected: TimeSeries(timeBase: FixedDate(50), items: [])),
        ])
        func setTimeBase(_ test: (series: TimeSeries<MocItem>, timeBase: FixedDate, expected: TimeSeries<MocItem>)) {
            #expect(test.series.setTimeBase(test.timeBase) == test.expected)
        }
    }

    @Suite("TimeSeriesSlice setTimeBase")
    struct TimeSeriesSliceTimeBase {
        @Test("TimeSeriesSlice setTimeBase", arguments: [
            (series: TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                    MocItem(time: 20, index: 2),
                                    MocItem(time: 30, index: 3),
                                    MocItem(time: 40, index: 4),
                                ])[0 ..< 4],
             timeBase: FixedDate(100),
             expected: TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 10, index: 1),
                                      MocItem(time: 20, index: 2),
                                      MocItem(time: 30, index: 3),
                                      MocItem(time: 40, index: 4),
                                  ])[0 ..< 4]),

            (series: TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                    MocItem(time: 20, index: 2),
                                    MocItem(time: 30, index: 3),
                                    MocItem(time: 40, index: 4),
                                ])[0 ..< 4],
             timeBase: FixedDate(50),
             expected: TimeSeries(timeBase: FixedDate(50),
                                  items: [
                                      MocItem(time: 60, index: 1),
                                      MocItem(time: 70, index: 2),
                                      MocItem(time: 80, index: 3),
                                      MocItem(time: 90, index: 4),
                                  ])[0 ..< 4]),

            (series: TimeSeriesSlice(timeBase: FixedDate(100), items: []),
             timeBase: FixedDate(50),
             expected: TimeSeriesSlice(timeBase: FixedDate(50), items: [])),
        ])
        func setTimeBase(_ test: (series: TimeSeriesSlice<MocItem>, timeBase: FixedDate, expected: TimeSeriesSlice<MocItem>)) {
            #expect(test.series.setTimeBase(test.timeBase) == test.expected)
        }
    }
}

extension TimeSeriesCollectionTests {
    @Suite("Accees items")
    struct TimeSeriesCollectionSubscription {
        typealias Series = TimeSeries<MocItem>

        private var series: Series {
            Series(timeBase: FixedDate(1000),
                   items: [
                       MocItem(time: 100, index: 0), // 0
                       MocItem(time: 200, index: 1), // 1
                       MocItem(time: 300, index: 2), // 2
                       MocItem(time: 400, index: 3), // 3
                       MocItem(time: 500, index: 4), // 4
                   ])
        }

        @Test("Element by position", arguments: [
            (index: 0, expected: (date: FixedDate(1100), item: MocItem(time: 100, index: 0))),
            (index: 1, expected: (date: FixedDate(1200), item: MocItem(time: 200, index: 1))),
            (index: 2, expected: (date: FixedDate(1300), item: MocItem(time: 300, index: 2))),
            (index: 3, expected: (date: FixedDate(1400), item: MocItem(time: 400, index: 3))),
            (index: 4, expected: (date: FixedDate(1500), item: MocItem(time: 500, index: 4))),
        ])
        func element(_ test: (index: Int, expected: (date: FixedDate, item: MocItem))) {
            #expect(series.element(at: test.index).date == test.expected.date)
            #expect(series.element(at: test.index).item == test.expected.item)
        }

        @Test("Elements", arguments: [
            (index: 0, expected: (date: FixedDate(1100), item: MocItem(time: 100, index: 0))),
            (index: 1, expected: (date: FixedDate(1200), item: MocItem(time: 200, index: 1))),
            (index: 2, expected: (date: FixedDate(1300), item: MocItem(time: 300, index: 2))),
            (index: 3, expected: (date: FixedDate(1400), item: MocItem(time: 400, index: 3))),
            (index: 4, expected: (date: FixedDate(1500), item: MocItem(time: 500, index: 4))),
        ])

        func elements(_ test: (index: Int, expected: (date: FixedDate, item: MocItem))) {
            let elements = series.elements()[0 ..< 5]
            #expect(elements[test.index].date == test.expected.date)
            #expect(elements[test.index].item == test.expected.item)

            #expect(elements.startIndex == 0)
            #expect(elements.endIndex == 5)
        }
    }

    @Suite("Accees items in slice")
    struct TimeSeriesCollectionSliceSubscription {
        typealias Series = TimeSeries<MocItem>.SubSequence
    }
}
