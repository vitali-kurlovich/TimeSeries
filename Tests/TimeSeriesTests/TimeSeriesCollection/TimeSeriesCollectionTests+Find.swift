//
//  TimeSeriesCollectionTests+Find.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 25.01.25.
//

import Testing
@testable import TimeSeries

extension TimeSeriesCollectionTests {
    @Suite("Find")
    struct TimeSeriesCollectionFind {
        typealias Series = TimeSeries<MocItem>

        private var series: Series {
            Series(timeBase: FixedDate(100),
                   items: [
                       MocItem(time: 10, index: 0), // 0
                       MocItem(time: 20, index: 1), // 1
                       MocItem(time: 30, index: 2), // 2
                       MocItem(time: 40, index: 3), // 3
                       MocItem(time: 50, index: 4), // 4
                   ])
        }

        @Test("Find by date",
              arguments: [
                  (date: FixedDate(0), item: nil),
                  (date: FixedDate(100), item: nil),
                  (date: FixedDate(110), item: MocItem(time: 10, index: 0)),
                  (date: FixedDate(120), item: MocItem(time: 20, index: 1)),
                  (date: FixedDate(130), item: MocItem(time: 30, index: 2)),
                  (date: FixedDate(140), item: MocItem(time: 40, index: 3)),
                  (date: FixedDate(150), item: MocItem(time: 50, index: 4)),
                  (date: FixedDate(160), item: nil),
              ])
        func itemByDate(_ test: (date: FixedDate, item: MocItem?)) throws {
            #expect(series[test.date] == test.item)

            let elements = series.elements()
            #expect(elements[test.date]?.item == test.item)
        }

        @Test("Find by date slice[2...3]",
              arguments: [
                  (date: FixedDate(0), item: nil),
                  (date: FixedDate(100), item: nil),
                  (date: FixedDate(110), item: nil),
                  (date: FixedDate(120), item: nil),
                  (date: FixedDate(130), item: MocItem(time: 30, index: 2)),
                  (date: FixedDate(140), item: MocItem(time: 40, index: 3)),
                  (date: FixedDate(150), item: nil),
                  (date: FixedDate(160), item: nil),
              ])
        func itemByDateSlice(_ test: (date: FixedDate, item: MocItem?)) throws {
            let slice = series[2 ... 3]
            #expect(slice[test.date] == test.item)

            let elements = slice.elements()
            #expect(elements[test.date]?.item == test.item)
        }
    }
}
