//
//  TimeSeriesCollectionTests+Split.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 28.01.25.
//

import Testing
@testable import TimeSeries

extension TimeSeriesCollectionTests {
    @Suite("TimeSeries Split")
    struct TimeSeriesCollectionSplit {
        @Test("Split maxCount",
              arguments: [
                  (series:

                      TimeSeries(timeBase: FixedDate(100), items: [
                          MocItem(time: 10, index: 0), // 0
                          MocItem(time: 20, index: 1), // 1
                          MocItem(time: 30, index: 2), // 2
                          MocItem(time: 40, index: 3), // 3

                          MocItem(time: 100, index: 4), // 4
                          MocItem(time: 200, index: 5), // 5
                          MocItem(time: 300, index: 6), // 6
                          MocItem(time: 400, index: 7), // 7

                          MocItem(time: 500, index: 8), // 8
                          MocItem(time: 600, index: 9), // 9
                          MocItem(time: 700, index: 10), // 10
                          MocItem(time: 800, index: 11), // 11
                      ]),
                      maxCount: 12,
                      expected: [
                          TimeSeriesSlice(timeBase: FixedDate(100), items: [
                              MocItem(time: 10, index: 0), // 0
                              MocItem(time: 20, index: 1), // 1
                              MocItem(time: 30, index: 2), // 2
                              MocItem(time: 40, index: 3), // 3

                              MocItem(time: 100, index: 4), // 4
                              MocItem(time: 200, index: 5), // 5
                              MocItem(time: 300, index: 6), // 6
                              MocItem(time: 400, index: 7), // 7

                              MocItem(time: 500, index: 8), // 8
                              MocItem(time: 600, index: 9), // 9
                              MocItem(time: 700, index: 10), // 10
                              MocItem(time: 800, index: 11), // 11
                          ]),
                      ]),

                  (series: TimeSeries(timeBase: FixedDate(100), items: [
                      MocItem(time: 10, index: 0), // 0
                      MocItem(time: 20, index: 1), // 1
                      MocItem(time: 30, index: 2), // 2
                      MocItem(time: 40, index: 3), // 3

                      MocItem(time: 100, index: 4), // 4
                      MocItem(time: 200, index: 5), // 5
                      MocItem(time: 300, index: 6), // 6
                      MocItem(time: 400, index: 7), // 7

                      MocItem(time: 500, index: 8), // 8
                      MocItem(time: 600, index: 9), // 9
                      MocItem(time: 700, index: 10), // 10
                      MocItem(time: 800, index: 11), // 11
                  ]),
                  maxCount: 4,
                  expected: [
                      TimeSeriesSlice(timeBase: FixedDate(100), items: [
                          MocItem(time: 10, index: 0), // 0
                          MocItem(time: 20, index: 1), // 1
                          MocItem(time: 30, index: 2), // 2
                          MocItem(time: 40, index: 3), // 3
                      ]),
                      TimeSeriesSlice(timeBase: FixedDate(200), items: [
                          MocItem(time: 0, index: 4), // 4
                          MocItem(time: 100, index: 5), // 5
                          MocItem(time: 200, index: 6), // 6
                          MocItem(time: 300, index: 7), // 7
                      ]),
                      TimeSeriesSlice(timeBase: FixedDate(600), items: [
                          MocItem(time: 0, index: 8), // 8
                          MocItem(time: 100, index: 9), // 9
                          MocItem(time: 200, index: 10), // 10
                          MocItem(time: 300, index: 11), // 11
                      ]),
                  ]),

                  (series: TimeSeries(timeBase: FixedDate(100), items: [
                      MocItem(time: 10, index: 0), // 0
                      MocItem(time: 20, index: 1), // 1
                      MocItem(time: 30, index: 2), // 2
                      MocItem(time: 40, index: 3), // 3

                      MocItem(time: 100, index: 4), // 4
                      MocItem(time: 200, index: 5), // 5
                      MocItem(time: 300, index: 6), // 6
                      MocItem(time: 400, index: 7), // 7

                      MocItem(time: 500, index: 8), // 8
                      MocItem(time: 600, index: 9), // 9
                      MocItem(time: 700, index: 10), // 10
                      MocItem(time: 800, index: 11), // 11
                  ]),
                  maxCount: 8,
                  expected: [
                      TimeSeriesSlice(timeBase: FixedDate(100), items: [
                          MocItem(time: 10, index: 0), // 0
                          MocItem(time: 20, index: 1), // 1
                          MocItem(time: 30, index: 2), // 2
                          MocItem(time: 40, index: 3), // 3

                          MocItem(time: 100, index: 4), // 4
                          MocItem(time: 200, index: 5), // 5
                          MocItem(time: 300, index: 6), // 6
                          MocItem(time: 400, index: 7), // 7
                      ]),
                      TimeSeriesSlice(timeBase: FixedDate(600), items: [
                          MocItem(time: 0, index: 8), // 8
                          MocItem(time: 100, index: 9), // 9
                          MocItem(time: 200, index: 10), // 10
                          MocItem(time: 300, index: 11), // 11
                      ]),
                  ]),

              ])
        func split(_ testData: (series: TimeSeries<MocItem>, maxCount: Int, expected: [TimeSeries<MocItem>.SubSequence])) {
            let split = testData.series.split(maxCount: testData.maxCount)

            #expect(split == testData.expected)
        }
    }
}

private enum TestsData {
    static let series = TimeSeries(timeBase: FixedDate(100),
                                   items: Self.seriesItems)

    static let seriesCase_50: [TimeSeriesSlice<MocItem>] = [
        .init(timeBase: FixedDate(50), items: []),
        .init(timeBase: FixedDate(100), items: .init(Self.seriesItems)),
    ]

    static let seriesCase_100: [TimeSeriesSlice<MocItem>] = [
        .init(timeBase: FixedDate(50), items: []),
        .init(timeBase: FixedDate(100), items: .init(Self.seriesItems)),
    ]

    static let seriesItems: [MocItem] = [
        MocItem(time: 10, index: 0), // 0
        MocItem(time: 20, index: 1), // 1
        MocItem(time: 30, index: 2), // 2
        MocItem(time: 40, index: 3), // 3

        MocItem(time: 100, index: 4), // 4
        MocItem(time: 200, index: 5), // 5
        MocItem(time: 300, index: 6), // 6
        MocItem(time: 400, index: 7), // 7

        MocItem(time: 500, index: 8), // 8
        MocItem(time: 600, index: 9), // 9
        MocItem(time: 700, index: 10), // 10
        MocItem(time: 800, index: 11), // 11
    ]
}
