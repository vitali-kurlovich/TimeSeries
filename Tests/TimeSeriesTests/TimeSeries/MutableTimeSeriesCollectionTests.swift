//
//  MutableTimeSeriesCollectionTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 26.12.24.
//

import Testing
@testable import TimeSeries

extension MutableTimeSeriesCollectionTests {
    typealias Series = TimeSeries<MocItem>

    struct TestCase {
        let series: Series
        let newTimeBase: FixedDate

        let canUpdate: Bool
    }
}

extension MutableTimeSeriesCollectionTests.TestCase {
    typealias Series = TimeSeries<MocItem>

    static func emptySeries(newTimeBase: FixedDate) -> Self {
        Self(series: Series(timeBase: FixedDate(200), items: []), newTimeBase: newTimeBase, canUpdate: true)
    }
}

struct MutableTimeSeriesCollectionTests {
    @Suite("TimeBase")
    struct TimeBase {
        @Test("Can update timeBase",
              arguments: [
                  TestCase.emptySeries(newTimeBase: .zero),
                  TestCase.emptySeries(newTimeBase: FixedDate(200)),
                  TestCase.emptySeries(newTimeBase: FixedDate(300)),

                  TestCase(series: Series(timeBase: FixedDate(32768 + 10), items: [.init(time: 10, index: 0)]),
                           newTimeBase: FixedDate(32768 + 10),
                           canUpdate: true),

                  TestCase(series: Series(timeBase: FixedDate(1), items: [.init(time: 10, index: 0)]),
                           newTimeBase: FixedDate(32768 + 10),
                           canUpdate: true),

                  TestCase(series: Series(timeBase: .zero, items: [.init(time: 10, index: 0)]),
                           newTimeBase: FixedDate(32768 + 10),
                           canUpdate: true),

                  TestCase(series: Series(timeBase: .zero, items: [.init(time: 10, index: 0)]),
                           newTimeBase: FixedDate(32768 + 11),
                           canUpdate: false),

                  TestCase(series: Series(timeBase: .zero, items: [.init(time: 10, index: 0)]),
                           newTimeBase: FixedDate(-(32767 - 10)),
                           canUpdate: true),

                  TestCase(series: Series(timeBase: .zero, items: [.init(time: 10, index: 0)]),
                           newTimeBase: FixedDate(-(32767 - 9)),
                           canUpdate: false),

              ])
        func canUpdateTimeBase(testCase: TestCase) throws {
            #expect(testCase.series.canUpdateTimeBase(to: testCase.newTimeBase) == testCase.canUpdate)
        }

        @Test("Update timeBase")
        func updateTimeBase() throws {
            var series = TimeSeries(timeBase: FixedDate(100),
                                    items: [
                                        MocItem(time: 10, index: 1),
                                        MocItem(time: 20, index: 2),
                                        MocItem(time: 30, index: 3),
                                        MocItem(time: 40, index: 4),
                                    ])

            series.updateTimeBase(FixedDate(50))

            let expected = TimeSeries(timeBase: FixedDate(50),
                                      items: [
                                          MocItem(time: 60, index: 1),
                                          MocItem(time: 70, index: 2),
                                          MocItem(time: 80, index: 3),
                                          MocItem(time: 90, index: 4),
                                      ])

            #expect(series == expected)

            let seriesDates = series.map {
                series.timeBase.adding(milliseconds: $0.time)
            }

            let expectedDates = expected.map {
                series.timeBase.adding(milliseconds: $0.time)
            }

            #expect(seriesDates == expectedDates)
        }
    }

    @Test("Insert to empty")
    func insertToEmpty() throws {
        var series = TimeSeries<MocItem>(timeBase: FixedDate(100),
                                         items: [])

        series.updateOrInsert(MocItem(time: 100, index: -1))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 100, index: -1),
                                  ])

        #expect(series == expected)
    }

    @Test("Insert to begin")
    func insertToBegin() throws {
        var series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                    MocItem(time: 20, index: 2),
                                    MocItem(time: 30, index: 3),
                                    MocItem(time: 40, index: 4),
                                ])

        series.updateOrInsert(MocItem(time: 5, index: -1))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 5, index: -1),
                                      MocItem(time: 10, index: 1),
                                      MocItem(time: 20, index: 2),
                                      MocItem(time: 30, index: 3),
                                      MocItem(time: 40, index: 4),
                                  ])

        #expect(series == expected)
    }

    @Test("Insert to begin")
    func insertToBegin_1() throws {
        var series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                ])

        series.updateOrInsert(MocItem(time: 5, index: -1))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 5, index: -1),
                                      MocItem(time: 10, index: 1),
                                  ])

        #expect(series == expected)
    }

    @Test("Update first")
    func updateFirst() throws {
        var series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                    MocItem(time: 20, index: 2),
                                    MocItem(time: 30, index: 3),
                                    MocItem(time: 40, index: 4),
                                ])

        series.updateOrInsert(MocItem(time: 10, index: 10))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 10, index: 10),
                                      MocItem(time: 20, index: 2),
                                      MocItem(time: 30, index: 3),
                                      MocItem(time: 40, index: 4),
                                  ])

        #expect(series == expected)
    }

    @Test("Update first")
    func updateFirst_1() throws {
        var series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                ])

        series.updateOrInsert(MocItem(time: 10, index: 10))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 10, index: 10),
                                  ])

        #expect(series == expected)
    }

    @Test("Insert to end")
    func insertToEnd() throws {
        var series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                    MocItem(time: 20, index: 2),
                                    MocItem(time: 30, index: 3),
                                    MocItem(time: 40, index: 4),
                                ])

        series.updateOrInsert(MocItem(time: 50, index: 5))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 10, index: 1),
                                      MocItem(time: 20, index: 2),
                                      MocItem(time: 30, index: 3),
                                      MocItem(time: 40, index: 4),
                                      MocItem(time: 50, index: 5),
                                  ])

        #expect(series == expected)
    }

    @Test("Insert to end")
    func insertToEnd_1() throws {
        var series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 40, index: 4),
                                ])

        series.updateOrInsert(MocItem(time: 50, index: 5))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 40, index: 4),
                                      MocItem(time: 50, index: 5),
                                  ])

        #expect(series == expected)
    }

    @Test("Update last")
    func updateLast() throws {
        var series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                    MocItem(time: 20, index: 2),
                                    MocItem(time: 30, index: 3),
                                    MocItem(time: 40, index: 4),
                                ])

        series.updateOrInsert(MocItem(time: 40, index: 100))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 10, index: 1),
                                      MocItem(time: 20, index: 2),
                                      MocItem(time: 30, index: 3),
                                      MocItem(time: 40, index: 100),
                                  ])

        #expect(series == expected)
    }

    @Test("Update last")
    func updateLast_1() throws {
        var series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 40, index: 4),
                                ])

        series.updateOrInsert(MocItem(time: 40, index: 100))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 40, index: 100),
                                  ])

        #expect(series == expected)
    }

    @Test("Insert at mid")
    func insertBetween() throws {
        var series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                    MocItem(time: 20, index: 2),
                                    MocItem(time: 30, index: 3),
                                    MocItem(time: 40, index: 4),
                                ])

        series.updateOrInsert(MocItem(time: 25, index: 100))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 10, index: 1),
                                      MocItem(time: 20, index: 2),
                                      MocItem(time: 25, index: 100),
                                      MocItem(time: 30, index: 3),
                                      MocItem(time: 40, index: 4),
                                  ])

        #expect(series == expected)
    }

    @Test("Update")
    func update() throws {
        var series = TimeSeries(timeBase: FixedDate(100),
                                items: [
                                    MocItem(time: 10, index: 1),
                                    MocItem(time: 20, index: 2),
                                    MocItem(time: 30, index: 3),
                                    MocItem(time: 40, index: 4),
                                ])

        series.updateOrInsert(MocItem(time: 10, index: 100))
        series.updateOrInsert(MocItem(time: 20, index: 200))
        series.updateOrInsert(MocItem(time: 30, index: 300))
        series.updateOrInsert(MocItem(time: 40, index: 400))

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 10, index: 100),
                                      MocItem(time: 20, index: 200),
                                      MocItem(time: 30, index: 300),
                                      MocItem(time: 40, index: 400),
                                  ])

        #expect(series == expected)
    }
}