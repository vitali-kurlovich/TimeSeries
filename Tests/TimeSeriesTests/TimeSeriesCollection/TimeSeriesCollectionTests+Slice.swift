//
//  TimeSeriesCollectionTests+Slice.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 24.01.25.
//

import Testing
@testable import TimeSeries

extension TimeSeriesCollectionTests {
    @Suite("TimeSeries Slice")
    struct TimeSeriesCollectionSlice {
        @Test("Empty TimeSeries Sliecing")
        func sliceEmptySeries() throws {
            let series = TimeSeriesSlice<MocItem>(timeBase: FixedDate(100), items: [])
            let interval = FixedDate(100) ... FixedDate(200)
            #expect(series[interval] == nil)
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

            let beforeInterval = FixedDate(10) ... FixedDate(90)

            #expect(series[beforeInterval] == nil)

            let afterInterval = FixedDate(141) ... FixedDate(200)

            #expect(series[afterInterval] == nil)

            let intervalAll = FixedDate(90) ... FixedDate(200)

            #expect(series[intervalAll] == series[0 ... 3])

            #expect(series[0 ... 3][1 ... 2] == series[1 ... 2])

            let intervalAllFit = FixedDate(110) ... FixedDate(140)

            #expect(series[intervalAllFit] == series[0 ... 3])
            #expect(series[FixedDate(100) ... FixedDate(140)] == series[0 ... 3])
            #expect(series[FixedDate(110) ... FixedDate(150)] == series[0 ... 3])
            #expect(series[FixedDate(111) ... FixedDate(139)] == series[1 ... 2])
        }

//        @Test("Split by time omittingEmpty",
//              arguments: [
//                  (series: TestsData.series, time: FixedDate(100), expected: [TestsData.series[0 ..< 12]]),
//                  (series: TestsData.series, time: FixedDate(110), expected: [TestsData.series[0 ..< 1], TestsData.series[1 ..< 12]]),
//                  (series: TestsData.series, time: FixedDate(140), expected: [TestsData.series[0 ... 3], TestsData.series[4 ..< 12]]),
//                  (series: TestsData.series, time: FixedDate(150), expected: [TestsData.series[0 ... 3], TestsData.series[4 ..< 12]]),
//                  (series: TestsData.series, time: FixedDate(900), expected: [TestsData.series[0 ... 10], TestsData.series[11 ..< 12]]),
//              ])
//        func split(_ test: (series: TimeSeries<MocItem>, time: FixedDate, expected: [TimeSeries<MocItem>.SubSequence])) {
//            let split = test.series.split(test.time, omittingEmptySubsequences: true)
//            #expect(split == test.expected)
//        }

        /*
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
         */
    }
}
