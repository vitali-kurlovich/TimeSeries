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

        @Test("Split maxCount",
              arguments: [
                  (series: TestsData.series, maxCount: 12, expected: [TestsData.series[0 ... 11]]),

                  (series: TestsData.series, maxCount: 4, expected: [
                      TestsData.series[0 ... 3],
                      TestsData.series[4 ... 7],
                      TestsData.series[8 ... 11],
                  ]),

                  (series: TestsData.series, maxCount: 8, expected: [
                      TestsData.series[0 ... 7],
                      TestsData.series[8 ... 11],
                  ]),

              ])
        func split(_ testData: (series: TimeSeries<MocItem>, maxCount: Int, expected: [TimeSeries<MocItem>.SubSequence])) {
            let split = testData.series.split(maxCount: testData.maxCount)

            #expect(split == testData.expected)
        }

        @Test("Split by time", arguments: [
            (series: TestsData.series,
             time: FixedDate(100),
             omittingEmpty: false,
             expected: [TestsData.series[0 ... 11]]),

            (series: TestsData.series, time: FixedDate(100), omittingEmpty: true, expected: [TestsData.series[0 ... 11]]),

            (series: TestsData.series, time: FixedDate(900), omittingEmpty: false, expected: [
                TestsData.series[0 ..< 12],
                .empty.setTimeBase(FixedDate(900))

            ]),

            (series: TestsData.series, time: FixedDate(900), omittingEmpty: true, expected: [
                TestsData.series[0 ..< 12],

            ]),

        ])
        func split(_ testData: (series: TimeSeries<MocItem>,
                                time: FixedDate,
                                omittingEmpty: Bool,
                                expected: [TimeSeries<MocItem>.SubSequence]))
        {
            let split = testData.series.split(testData.time, omittingEmptySubsequences: testData.omittingEmpty)

            #expect(split == testData.expected)
        }
    }
}

private enum TestsData {
    static let series = TimeSeries(timeBase: FixedDate(100),
                                   items: Self.seriesItems)
    static let seriesItems: [MocItem] = [
        MocItem(time: 10, index: 1), // 0
        MocItem(time: 20, index: 2), // 1
        MocItem(time: 30, index: 3), // 2
        MocItem(time: 40, index: 4), // 3

        MocItem(time: 100, index: 5), // 4
        MocItem(time: 200, index: 6), // 5
        MocItem(time: 300, index: 7), // 6
        MocItem(time: 400, index: 8), // 7

        MocItem(time: 500, index: 9), // 8
        MocItem(time: 600, index: 10), // 9
        MocItem(time: 700, index: 11), // 10
        MocItem(time: 800, index: 12), // 11
    ]
}
