//
//  TimeSeriesCollectionTests+Index.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 24.01.25.
//

import Testing
@testable import TimeSeries

extension TimeSeriesCollectionTests {
    @Suite("Find index")
    struct TimeSeriesCollectionFindTimeOffsetIndex {
        typealias Series = TimeSeries<MocItem>

        private var series: Series {
            Series(timeBase: FixedDate(100),
                   items: [
                       MocItem(time: 10, index: 0), // 0
                       MocItem(time: 20, index: 1), // 1
                       MocItem(time: 30, index: 2), // 2
                       MocItem(time: 40, index: 3), // 3
                   ])
        }

        private var seriesSecond: Series {
            Series(timeBase: FixedDate(100),
                   items: [
                       MocItem(time: 10, index: 0), // 0
                       MocItem(time: 20, index: 1), // 1
                       MocItem(time: 30, index: 2), // 2
                       MocItem(time: 40, index: 3), // 3
                       MocItem(time: 50, index: 4), // 4
                   ])
        }

        private var seriesOne: Series {
            Series(timeBase: FixedDate(100),
                   items: [
                       MocItem(time: 10, index: 0), // 0
                   ])
        }

        private var emptySeries: Series {
            Series(timeBase: FixedDate(100), items: [])
        }

        @Test("Index",
              arguments: [
                  (offset: 5, index: nil),
                  (offset: 10, index: 0),
                  (offset: 15, index: nil),
                  (offset: 20, index: 1),
                  (offset: 25, index: nil),
                  (offset: 30, index: 2),
                  (offset: 35, index: nil),
                  (offset: 40, index: 3),
                  (offset: 45, index: nil),

              ])
        func index(_ test: (offset: Int16, index: Int?)) throws {
            let series = self.series
            #expect(series.index(with: test.offset) == test.index)
            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.index(with: time) == test.index)
        }

        @Test("Index",
              arguments: [
                  (offset: 5, index: nil),
                  (offset: 10, index: 0),
                  (offset: 15, index: nil),
                  (offset: 20, index: 1),
                  (offset: 25, index: nil),
                  (offset: 30, index: 2),
                  (offset: 35, index: nil),
                  (offset: 40, index: 3),
                  (offset: 45, index: nil),
                  (offset: 50, index: 4),
                  (offset: 55, index: nil),

              ])
        func index_2(_ test: (offset: Int16, index: Int?)) throws {
            let series = seriesSecond
            #expect(series.index(with: test.offset) == test.index)
            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.index(with: time) == test.index)
        }

        @Test("Index in series of one",
              arguments: [
                  (offset: 5, index: nil),
                  (offset: 10, index: 0),
                  (offset: 15, index: nil),
              ])
        func indexOfOne(_ test: (offset: Int16, index: Int?)) throws {
            let series = seriesOne

            #expect(series.index(with: test.offset) == test.index)
            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.index(with: time) == test.index)
        }

        @Test("Index in empty series",
              arguments: [
                  0, 5, 10, 20,
              ])
        func indexOfEmpty(_ offset: Int16) throws {
            let series = emptySeries
            #expect(series.index(with: offset) == nil)
            let time = series.timeBase.adding(milliseconds: offset)
            #expect(series.index(with: time) == nil)
        }
    }
}

extension TimeSeriesCollectionTests {
    @Suite("Find first index")
    struct TimeSeriesCollectionFindFirstTimeOffsetIndex {
        typealias Series = TimeSeries<MocItem>

        private var series: Series {
            Series(timeBase: FixedDate(100),
                   items: [
                       MocItem(time: 10, index: 0), // 0
                       MocItem(time: 20, index: 1), // 1
                       MocItem(time: 30, index: 2), // 2
                       MocItem(time: 40, index: 3), // 3
                   ])
        }

        private var seriesSecond: Series {
            Series(timeBase: FixedDate(100),
                   items: [
                       MocItem(time: 10, index: 0), // 0
                       MocItem(time: 20, index: 1), // 1
                       MocItem(time: 30, index: 2), // 2
                       MocItem(time: 40, index: 3), // 3
                       MocItem(time: 50, index: 4), // 4
                   ])
        }

        private var seriesOne: Series {
            Series(timeBase: FixedDate(100),
                   items: [
                       MocItem(time: 10, index: 0), // 0
                   ])
        }

        private var emptySeries: Series {
            Series(timeBase: FixedDate(100), items: [])
        }

        @Test("First Index withTimeOffsetGreaterThan",
              arguments: [
                  (offset: 5, index: 0), // 10
                  (offset: 10, index: 1), // 20
                  (offset: 15, index: 1), // 20
                  (offset: 20, index: 2), // 30
                  (offset: 25, index: 2), // 30
                  (offset: 30, index: 3), // 40
                  (offset: 35, index: 3), // 40
                  (offset: 40, index: nil),
                  (offset: 45, index: nil),

              ])
        func firstIndexGreaterThan(_ test: (offset: Int16, index: Int?)) throws {
            let series = self.series
            #expect(series.firstIndex(withTimeOffsetGreaterThan: test.offset) == test.index)

            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.firstIndex(greater: time) == test.index)
        }

        @Test("First Index withTimeOffsetGreaterThan",
              arguments: [
                  (offset: 5, index: 0), // 10
                  (offset: 10, index: 1), // 20
                  (offset: 15, index: 1), // 20
                  (offset: 20, index: 2), // 30
                  (offset: 25, index: 2), // 30
                  (offset: 30, index: 3), // 40
                  (offset: 35, index: 3), // 40
                  (offset: 40, index: 4), // 50
                  (offset: 45, index: 4), // 50
                  (offset: 50, index: nil),
                  (offset: 55, index: nil),
              ])
        func firstIndexGreaterThan_(_ test: (offset: Int16, index: Int?)) throws {
            let series = seriesSecond
            #expect(series.firstIndex(withTimeOffsetGreaterThan: test.offset) == test.index)
            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.firstIndex(greater: time) == test.index)
        }

        @Test("First Index withTimeOffsetGreaterThan slice[2...3]",
              arguments: [
                  (offset: 5, index: 2), // 20
                  (offset: 10, index: 2), // 20
                  (offset: 15, index: 2), // 20
                  (offset: 20, index: 2), // 30
                  (offset: 25, index: 2), // 30
                  (offset: 30, index: 3), // 40
                  (offset: 35, index: 3), // 40
                  (offset: 40, index: nil),
                  (offset: 45, index: nil),
                  (offset: 50, index: nil),
                  (offset: 55, index: nil),
              ])
        func firstIndexGreaterThanSlice(_ test: (offset: Int16, index: Int?)) throws {
            let series = seriesSecond
            let slice = series[2 ... 3]

            #expect(slice.firstIndex(withTimeOffsetGreaterThan: test.offset) == test.index)

            let time = slice.timeBase.adding(milliseconds: test.offset)
            #expect(slice.firstIndex(greater: time) == test.index)
        }

        @Test("First Index withTimeOffsetGreaterThan for one item series")
        func firstIndexGreaterThanOfOne() throws {
            let series = seriesOne

            #expect(series.firstIndex(withTimeOffsetGreaterThan: 0) == 0)
            #expect(series.firstIndex(withTimeOffsetGreaterThan: 10) == nil)
            #expect(series.firstIndex(withTimeOffsetGreaterThan: 20) == nil)

            #expect(series.firstIndex(greater: FixedDate(0)) == 0)
            #expect(series.firstIndex(greater: FixedDate(100)) == 0)
            #expect(series.firstIndex(greater: FixedDate(110)) == nil)
            #expect(series.firstIndex(greater: FixedDate(120)) == nil)
        }

        @Test("First Index withTimeOffsetGreaterThan for empty series")
        func firstIndexGreaterThan() throws {
            let series = emptySeries

            #expect(series.firstIndex(withTimeOffsetGreaterThan: 0) == nil)
            #expect(series.firstIndex(withTimeOffsetGreaterThan: 10) == nil)
            #expect(series.firstIndex(withTimeOffsetGreaterThan: 20) == nil)

            #expect(series.firstIndex(greater: FixedDate(0)) == nil)
            #expect(series.firstIndex(greater: FixedDate(100)) == nil)
            #expect(series.firstIndex(greater: FixedDate(110)) == nil)
            #expect(series.firstIndex(greater: FixedDate(120)) == nil)
        }

        @Test("First Index withTimeOffsetGreaterOrEqualThan",
              arguments: [
                  (offset: 5, index: 0), // 10
                  (offset: 10, index: 0), // 10
                  (offset: 15, index: 1), // 20
                  (offset: 20, index: 1), // 20
                  (offset: 25, index: 2), // 30
                  (offset: 30, index: 2), // 30
                  (offset: 35, index: 3), // 40
                  (offset: 40, index: 3), // 40
                  (offset: 45, index: nil),

              ])
        func firstIndexGreaterOrEqualThan(_ test: (offset: Int16, index: Int?)) throws {
            let series = self.series
            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: test.offset) == test.index)
        }

        @Test("First Index withTimeOffsetGreaterOrEqualThan",
              arguments: [
                  (offset: 5, index: 0), // 10
                  (offset: 10, index: 0), // 10
                  (offset: 15, index: 1), // 20
                  (offset: 20, index: 1), // 20
                  (offset: 25, index: 2), // 30
                  (offset: 30, index: 2), // 30
                  (offset: 35, index: 3), // 40
                  (offset: 40, index: 3), // 40
                  (offset: 45, index: 4), // 50
                  (offset: 50, index: 4), // 50
                  (offset: 55, index: nil),
              ])
        func firstIndexGreaterOrEqualThan_(_ test: (offset: Int16, index: Int?)) throws {
            let series = seriesSecond
            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: test.offset) == test.index)
        }

        @Test("First Index withTimeOffsetGreaterOrEqualThan silec[2...3]",
              arguments: [
                  (offset: 5, index: 2), // 10
                  (offset: 10, index: 2), // 10
                  (offset: 15, index: 2), // 20
                  (offset: 20, index: 2), // 20
                  (offset: 25, index: 2), // 30
                  (offset: 30, index: 2), // 30
                  (offset: 35, index: 3), // 40
                  (offset: 40, index: 3), // 40
                  (offset: 45, index: nil), // 50
                  (offset: 50, index: nil), // 50
                  (offset: 55, index: nil),
              ])
        func firstIndexGreaterOrEqualThanSlice(_ test: (offset: Int16, index: Int?)) throws {
            let series = seriesSecond
            let slice = series[2 ... 3]

            #expect(slice.firstIndex(withTimeOffsetGreaterOrEqualThan: test.offset) == test.index)
        }

        @Test("First Index withTimeOffsetGreaterOrEqualThan for one item series")
        func firstIndexGreaterOrEqualThanOfOne() throws {
            let series = seriesOne

            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: 0) == 0)
            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: 10) == 0)
            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: 20) == nil)
        }

        @Test("First Index withTimeOffsetGreaterOrEqualThan for empty series")
        func firstIndexGreaterOrEqualThan() throws {
            let series = emptySeries

            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: 0) == nil)
            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: 10) == nil)
            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: 20) == nil)
        }
    }
}

extension TimeSeriesCollectionTests {
    @Suite("Find last index")
    struct TimeSeriesCollectionFindLastTimeOffsetIndex {
        typealias Series = TimeSeries<MocItem>

        private var series: Series {
            Series(timeBase: FixedDate(100),
                   items: [
                       MocItem(time: 10, index: 0), // 0
                       MocItem(time: 20, index: 1), // 1
                       MocItem(time: 30, index: 2), // 2
                       MocItem(time: 40, index: 3), // 3
                   ])
        }

        private var seriesSecond: Series {
            Series(timeBase: FixedDate(100),
                   items: [
                       MocItem(time: 10, index: 0), // 0
                       MocItem(time: 20, index: 1), // 1
                       MocItem(time: 30, index: 2), // 2
                       MocItem(time: 40, index: 3), // 3
                       MocItem(time: 50, index: 4), // 4
                   ])
        }

        private var seriesOne: Series {
            Series(timeBase: FixedDate(100),
                   items: [
                       MocItem(time: 10, index: 0), // 0
                   ])
        }

        private var emptySeries: Series {
            Series(timeBase: FixedDate(100), items: [])
        }

        @Test("Last Index withTimeOffsetLessThan",
              arguments: [
                  (offset: 5, index: nil),
                  (offset: 10, index: nil),
                  (offset: 15, index: 0), // 10
                  (offset: 20, index: 0), // 10
                  (offset: 25, index: 1), // 20
                  (offset: 30, index: 1), // 20
                  (offset: 35, index: 2), // 30
                  (offset: 40, index: 2), // 30
                  (offset: 45, index: 3), // 40

              ])
        func lastIndexLessThan(_ test: (offset: Int16, index: Int?)) throws {
            let series = self.series

            #expect(series.lastIndex(withTimeOffsetLessThan: test.offset) == test.index)
        }

        @Test("Last Index withTimeOffsetLessThan",
              arguments: [
                  (offset: 5, index: nil),
                  (offset: 10, index: nil),
                  (offset: 15, index: 0), // 10
                  (offset: 20, index: 0), // 10
                  (offset: 25, index: 1), // 20
                  (offset: 30, index: 1), // 20
                  (offset: 35, index: 2), // 30
                  (offset: 40, index: 2), // 30
                  (offset: 45, index: 3), // 40
                  (offset: 50, index: 3), // 40
                  (offset: 55, index: 4), // 50

              ])
        func lastIndexLessThan_(_ test: (offset: Int16, index: Int?)) throws {
            let series = seriesSecond
            #expect(series.lastIndex(withTimeOffsetLessThan: test.offset) == test.index)
        }

        @Test("Last Index withTimeOffsetLessThan for series of one")
        func lastIndexLessThanOfOne() throws {
            let series = seriesOne

            #expect(series.lastIndex(withTimeOffsetLessThan: 0) == nil)
            #expect(series.lastIndex(withTimeOffsetLessThan: 10) == nil)
            #expect(series.lastIndex(withTimeOffsetLessThan: 20) == 0)
        }

        @Test("Last Index withTimeOffsetLessThan for empty series")
        func lastIndexLessThan() throws {
            let series = emptySeries
            #expect(series.lastIndex(withTimeOffsetLessThan: 0) == nil)
            #expect(series.lastIndex(withTimeOffsetLessThan: 10) == nil)
            #expect(series.lastIndex(withTimeOffsetLessThan: 20) == nil)
        }

        @Test("Last Index withTimeOffsetLessOrEqualThan",
              arguments: [
                  (offset: 5, index: nil),
                  (offset: 10, index: 0), // 10
                  (offset: 15, index: 0), // 10
                  (offset: 20, index: 1), // 20
                  (offset: 25, index: 1), // 20
                  (offset: 30, index: 2), // 30
                  (offset: 35, index: 2), // 30
                  (offset: 40, index: 3), // 40
                  (offset: 45, index: 3), // 40

              ])
        func lastIndexLessOrEqualThan(_ test: (offset: Int16, index: Int?)) throws {
            let series = self.series
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: test.offset) == test.index)
        }

        @Test("First Index withTimeOffsetLessOrEqualThan",
              arguments: [
                  (offset: 5, index: nil),
                  (offset: 10, index: 0), // 10
                  (offset: 15, index: 0), // 10
                  (offset: 20, index: 1), // 20
                  (offset: 25, index: 1), // 20
                  (offset: 30, index: 2), // 30
                  (offset: 35, index: 2), // 30
                  (offset: 40, index: 3), // 40
                  (offset: 45, index: 3), // 40
                  (offset: 50, index: 4), // 50
                  (offset: 55, index: 4), // 50

              ])
        func lastIndexLessOrEqualThan_(_ test: (offset: Int16, index: Int?)) throws {
            let series = seriesSecond
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: test.offset) == test.index)
        }

        @Test("Last Index withTimeOffsetLessOrEqualThan for series of one")
        func lastIndexLessOrEqualThanOfOne() throws {
            let series = seriesOne

            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 0) == nil)
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 10) == 0)
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 20) == 0)
        }

        @Test("Last Index withTimeOffsetLessOrEqualThan for empty series")
        func lastIndexLessOrEqualThan() throws {
            let series = emptySeries
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 0) == nil)
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 10) == nil)
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 20) == nil)
        }
    }
}
