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
        func split(_ test: (series: TimeSeries<MocItem>, maxCount: Int, expected: [TimeSeries<MocItem>.SubSequence])) {
            let split = test.series.split(maxCount: test.maxCount)

            #expect(split == test.expected)
        }

        @Test("Split position", arguments: [
            (series:
                TimeSeries(timeBase: FixedDate(100), items: [
                    MocItem(time: 10, index: 0), // 0
                ]),
                position: 0,
                expected: [
                    TimeSeriesSlice(timeBase: FixedDate(100), items: [
                        MocItem(time: 10, index: 0), // 0
                    ]),
                ]),

            (series:
                TimeSeries(timeBase: FixedDate(100), items: [
                    MocItem(time: 10, index: 0), // 0
                    MocItem(time: 20, index: 1), // 1
                ]),
                position: 0,
                expected: [
                    TimeSeriesSlice(timeBase: FixedDate(100), items: [
                        MocItem(time: 10, index: 0), // 0
                    ]),
                    TimeSeriesSlice(timeBase: FixedDate(120), items: [
                        MocItem(time: 0, index: 1), // 1
                    ]),
                ]),

            (series:
                TimeSeries(timeBase: FixedDate(100), items: [
                    MocItem(time: 10, index: 0), // 0
                    MocItem(time: 20, index: 1), // 1
                ]),
                position: 1,
                expected: [
                    TimeSeriesSlice(timeBase: FixedDate(100), items: [
                        MocItem(time: 10, index: 0), // 0
                    ]),
                    TimeSeriesSlice(timeBase: FixedDate(120), items: [
                        MocItem(time: 0, index: 1), // 1
                    ]),
                ]),

            (series:
                TimeSeries(timeBase: FixedDate(100), items: [
                    MocItem(time: 10, index: 0), // 0
                    MocItem(time: 20, index: 1), // 1
                    MocItem(time: 30, index: 2), // 2
                ]),
                position: 0,
                expected: [
                    TimeSeriesSlice(timeBase: FixedDate(100), items: [
                        MocItem(time: 10, index: 0), // 0
                    ]),
                    TimeSeriesSlice(timeBase: FixedDate(120), items: [
                        MocItem(time: 0, index: 1), // 1
                        MocItem(time: 10, index: 2), // 2
                    ]),
                ]),

            (series:
                TimeSeries(timeBase: FixedDate(100), items: [
                    MocItem(time: 10, index: 0), // 0
                    MocItem(time: 20, index: 1), // 1
                    MocItem(time: 30, index: 2), // 2
                ]),
                position: 1,
                expected: [
                    TimeSeriesSlice(timeBase: FixedDate(100), items: [
                        MocItem(time: 10, index: 0), // 0
                    ]),

                    TimeSeriesSlice(timeBase: FixedDate(120), items: [
                        MocItem(time: 0, index: 1), // 1
                    ]),

                    TimeSeriesSlice(timeBase: FixedDate(130), items: [
                        MocItem(time: 0, index: 2), // 2
                    ]),
                ]),

            (series:
                TimeSeries(timeBase: FixedDate(100), items: [
                    MocItem(time: 10, index: 0), // 0
                    MocItem(time: 20, index: 1), // 1
                    MocItem(time: 30, index: 2), // 2
                ]),
                position: 2,
                expected: [
                    TimeSeriesSlice(timeBase: FixedDate(100), items: [
                        MocItem(time: 10, index: 0), // 0
                        MocItem(time: 20, index: 1), // 1
                    ]),

                    TimeSeriesSlice(timeBase: FixedDate(130), items: [
                        MocItem(time: 0, index: 2), // 2
                    ]),
                ]),

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
                position: 0,
                expected: [
                    TimeSeriesSlice(timeBase: FixedDate(100), items: [
                        MocItem(time: 10, index: 0), // 0
                    ]),
                    TimeSeriesSlice(timeBase: FixedDate(120), items: [
                        MocItem(time: 0, index: 1), // 1
                        MocItem(time: 10, index: 2), // 2
                        MocItem(time: 20, index: 3), // 3

                        MocItem(time: 80, index: 4), // 4
                        MocItem(time: 180, index: 5), // 5
                        MocItem(time: 280, index: 6), // 6
                        MocItem(time: 380, index: 7), // 7

                        MocItem(time: 480, index: 8), // 8
                        MocItem(time: 580, index: 9), // 9
                        MocItem(time: 680, index: 10), // 10
                        MocItem(time: 780, index: 11), // 11
                    ]),
                ]),
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
                position: 11,
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
                    ]),

                    TimeSeriesSlice(timeBase: FixedDate(900), items: [
                        MocItem(time: 0, index: 11), // 11
                    ]),
                ]),

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
                position: 6,
                expected: [
                    TimeSeriesSlice(timeBase: FixedDate(100), items: [
                        MocItem(time: 10, index: 0), // 0
                        MocItem(time: 20, index: 1), // 1
                        MocItem(time: 30, index: 2), // 2
                        MocItem(time: 40, index: 3), // 3
                        MocItem(time: 100, index: 4), // 4
                        MocItem(time: 200, index: 5), // 5

                    ]),

                    TimeSeriesSlice(timeBase: FixedDate(400), items: [
                        MocItem(time: 0, index: 6), // 6
                    ]),

                    TimeSeriesSlice(timeBase: FixedDate(500), items: [
                        MocItem(time: 0, index: 7), // 7
                        MocItem(time: 100, index: 8), // 8
                        MocItem(time: 200, index: 9), // 9
                        MocItem(time: 300, index: 10), // 10
                        MocItem(time: 400, index: 11), // 11
                    ])
                ]),

        ])
        func split(_ test: (series: TimeSeries<MocItem>, position: Int, expected: [TimeSeries<MocItem>.SubSequence])) {
            let split = test.series.split(position: test.position)

            #expect(split == test.expected)
        }

        @Test("Split by time", arguments: [
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
                time: FixedDate(400),
                expected: [
                    TimeSeriesSlice(timeBase: FixedDate(100), items: [
                        MocItem(time: 10, index: 0), // 0
                        MocItem(time: 20, index: 1), // 1
                        MocItem(time: 30, index: 2), // 2
                        MocItem(time: 40, index: 3), // 3
                        MocItem(time: 100, index: 4), // 4
                        MocItem(time: 200, index: 5), // 5

                    ]),

                    TimeSeriesSlice(timeBase: FixedDate(400), items: [
                        MocItem(time: 0, index: 6), // 6
                    ]),

                    TimeSeriesSlice(timeBase: FixedDate(500), items: [
                        MocItem(time: 0, index: 7), // 7
                        MocItem(time: 100, index: 8), // 8
                        MocItem(time: 200, index: 9), // 9
                        MocItem(time: 300, index: 10), // 10
                        MocItem(time: 400, index: 11), // 11
                    ])
                ]),

        ])
        func split(_ test: (series: TimeSeries<MocItem>, time: FixedDate, expected: [TimeSeries<MocItem>.SubSequence])) {
            let split = test.series.split(time: test.time)

            #expect(split == test.expected)
        }
    }
}
