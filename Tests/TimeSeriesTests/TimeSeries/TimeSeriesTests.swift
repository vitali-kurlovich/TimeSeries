//
//  TimeSeriesTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 12.12.24.
//

import Testing
@testable import TimeSeries

struct TimeSeriesTests {
    @Test("TimeSeries normalization")
    func normalized() throws {
        let emptyItems: [MocItem] = []

        let empty = TimeSeries(timeBase: FixedDate(100), items: emptyItems)
        #expect(empty.normalized() == .empty)

        let normalized = TimeSeries(timeBase: FixedDate(100),
                                    items: [
                                        MocItem(time: 0, index: 1),
                                        MocItem(time: 10, index: 2),
                                    ])

        #expect(normalized == normalized.normalized())

        let unnormalized = TimeSeries(timeBase: FixedDate(100),
                                      items: [
                                          MocItem(time: 10, index: 1),
                                          MocItem(time: 20, index: 2),
                                      ])

        let expected = TimeSeries(timeBase: FixedDate(110),
                                  items: [
                                      MocItem(time: 0, index: 1),
                                      MocItem(time: 10, index: 2),
                                  ])

        #expect(expected == unnormalized.normalized())

        #expect(unnormalized.normalized() == unnormalized.normalized().normalized())
    }

    @Test("TimeSeries normalization for slice")
    func sliceNormalized() throws {
        let normalized = TimeSeries(timeBase: FixedDate(100),
                                    items: [
                                        MocItem(time: 0, index: 1),
                                        MocItem(time: 10, index: 2),
                                    ])[0 ... 1]

        #expect(TimeSeries(normalized) == normalized.normalized())

        let unnormalized = TimeSeries(timeBase: FixedDate(100),
                                      items: [
                                          MocItem(time: 10, index: 1),
                                          MocItem(time: 20, index: 2),
                                          MocItem(time: 30, index: 3),
                                          MocItem(time: 40, index: 4),
                                      ])[1 ... 2]

        let expected = TimeSeries(timeBase: FixedDate(120),
                                  items: [
                                      MocItem(time: 0, index: 2),
                                      MocItem(time: 10, index: 3),
                                  ])

        #expect(expected == unnormalized.normalized())
        #expect(unnormalized.normalized() == unnormalized.normalized().normalized())
    }

    @Test("TimeSeries union")
    func union() throws {
        let first = TimeSeries(timeBase: FixedDate(100),
                               items: [
                                   MocItem(time: 10, index: 1),
                                   MocItem(time: 20, index: 2),
                               ])

        let second = TimeSeries(timeBase: FixedDate(200),
                                items: [
                                    MocItem(time: 10, index: 3),
                                    MocItem(time: 20, index: 4),
                                    MocItem(time: 30, index: 5),
                                ])[0 ... 1]

        let expected = TimeSeries(timeBase: FixedDate(100),
                                  items: [
                                      MocItem(time: 10, index: 1),
                                      MocItem(time: 20, index: 2),
                                      MocItem(time: 110, index: 3),
                                      MocItem(time: 120, index: 4),
                                  ]).normalized()

        #expect(first.union(second) == expected)
        #expect(second.union(first) == expected)
    }

    @Test("TimeSeries union with empty")
    func unionWithEmpty() throws {
        let first = TimeSeries<MocItem>(timeBase: FixedDate(100),
                                        items: [])

        let second = TimeSeries(timeBase: FixedDate(200),
                                items: [
                                    MocItem(time: 10, index: 3),
                                    MocItem(time: 20, index: 4),
                                    MocItem(time: 30, index: 5),
                                ])[0 ... 1]

        let expected = TimeSeries(timeBase: FixedDate(200),
                                  items: [
                                      MocItem(time: 10, index: 3),
                                      MocItem(time: 20, index: 4),
                                  ]).normalized()

        #expect(first.union(second) == expected)
        #expect(second.union(first) == expected)

        let emptyFirst = TimeSeriesSlice<MocItem>(timeBase: FixedDate(200), items: [])
        let emptySecond = TimeSeries<MocItem>(timeBase: FixedDate(1200), items: [])

        #expect(emptyFirst.union(emptySecond) == .empty)
        #expect(emptySecond.union(emptyFirst) == .empty)
    }
}
