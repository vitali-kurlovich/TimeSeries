//
//  TimeSeriesCollectionTests+IndexByDate.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 25.01.25.
//

import Testing
@testable import TimeSeries

extension TimeSeriesCollectionTests {
    @Suite("Find index by date")
    struct TimeSeriesCollectionFindIndexByDate {
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

        @Test("Index by date",
              arguments: [
                  (date: FixedDate(0), index: nil),
                  (date: FixedDate(100), index: nil),
                  (date: FixedDate(110), index: 0),
                  (date: FixedDate(120), index: 1),
                  (date: FixedDate(130), index: 2),
                  (date: FixedDate(140), index: 3),
                  (date: FixedDate(150), index: 4),
                  (date: FixedDate(160), index: nil),
              ])
        func itemByDate(_ test: (date: FixedDate, index: Int?)) throws {
            #expect(series.index(with: test.date) == test.index)
        }

        @Test("Index by date in slice[2...3]",
              arguments: [
                  (date: FixedDate(0), index: nil),
                  (date: FixedDate(100), index: nil),
                  (date: FixedDate(110), index: nil),
                  (date: FixedDate(120), index: nil),
                  (date: FixedDate(130), index: 2),
                  (date: FixedDate(140), index: 3),
                  (date: FixedDate(150), index: nil),
                  (date: FixedDate(160), index: nil),
              ])
        func itemByDateSlice(_ test: (date: FixedDate, index: Int?)) throws {
            let slice = series[2 ... 3]
            #expect(slice.index(with: test.date) == test.index)
        }
    }
}
