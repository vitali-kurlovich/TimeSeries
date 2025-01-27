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
                  (time: FixedDate(105), index: nil),
                  (time: FixedDate(110), index: 0),
                  (time: FixedDate(115), index: nil),
                  (time: FixedDate(120), index: 1),
                  (time: FixedDate(125), index: nil),
                  (time: FixedDate(130), index: 2),
                  (time: FixedDate(135), index: nil),
                  (time: FixedDate(140), index: 3),
                  (time: FixedDate(145), index: nil)
              ])
        func index(_ test: (time: FixedDate, index: Int?)) throws {
            let series = self.series
            #expect(series.index(with: test.time) == test.index)
        }

        @Test("Index",
              arguments: [
                  (time: FixedDate(105), index: nil),
                  (time: FixedDate(110), index: 0),
                  (time: FixedDate(115), index: nil),
                  (time: FixedDate(120), index: 1),
                  (time: FixedDate(125), index: nil),
                  (time: FixedDate(130), index: 2),
                  (time: FixedDate(135), index: nil),
                  (time: FixedDate(140), index: 3),
                  (time: FixedDate(145), index: nil),
                  (time: FixedDate(150), index: 4),
                  (time: FixedDate(155), index: nil)
              ])
        func index_2(_ test: (time: FixedDate, index: Int?)) throws {
            let series = seriesSecond
            #expect(series.index(with: test.time) == test.index)
        }

        @Test("Index in series of one")
        func indexOfOne() throws {
            let series = seriesOne

            #expect(series.index(with: FixedDate(105)) == nil)
            #expect(series.index(with: FixedDate(110)) == 0)
            #expect(series.index(with: FixedDate(115)) == nil)
        }

        @Test("Index in empty series")
        func indexOfEmpty() throws {
            let series = emptySeries
            #expect(series.index(with: FixedDate(0)) == nil)
            #expect(series.index(with: FixedDate(100)) == nil)
            #expect(series.index(with: FixedDate(110)) == nil)
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
                  (time: FixedDate(105), index: 0), // 110
                  (time: FixedDate(110), index: 1), // 120
                  (time: FixedDate(115), index: 1), // 120
                  (time: FixedDate(120), index: 2), // 130
                  (time: FixedDate(125), index: 2), // 130
                  (time: FixedDate(130), index: 3), // 140
                  (time: FixedDate(135), index: 3), // 140
                  (time: FixedDate(140), index: nil),
                  (time: FixedDate(145), index: nil),

              ])
        func firstIndexGreaterThan(_ test: (time: FixedDate, index: Int?)) throws {
            let series = self.series
            #expect(series.firstIndex(greater: test.time) == test.index)
        }

        @Test("First Index withTimeOffsetGreaterThan",
              arguments: [
                  (time: FixedDate(105), index: 0), // 110
                  (time: FixedDate(110), index: 1), // 120
                  (time: FixedDate(115), index: 1), // 120
                  (time: FixedDate(120), index: 2), // 130
                  (time: FixedDate(125), index: 2), // 130
                  (time: FixedDate(130), index: 3), // 140
                  (time: FixedDate(135), index: 3), // 140
                  (time: FixedDate(140), index: 4), // 150
                  (time: FixedDate(145), index: 4), // 150
                  (time: FixedDate(150), index: nil),
                  (time: FixedDate(155), index: nil),
              ])
        func firstIndexGreaterThan_(_ test: (time: FixedDate, index: Int?)) throws {
            let series = seriesSecond
            #expect(series.firstIndex(greater: test.time) == test.index)
        }

        @Test("First Index greater slice[2...3]",
              arguments: [
                  (time: FixedDate(105), index: 2), // 20
                  (time: FixedDate(110), index: 2), // 20
                  (time: FixedDate(115), index: 2), // 20
                  (time: FixedDate(120), index: 2), // 30
                  (time: FixedDate(125), index: 2), // 30
                  (time: FixedDate(130), index: 3), // 40
                  (time: FixedDate(135), index: 3), // 40
                  (time: FixedDate(140), index: nil),
                  (time: FixedDate(145), index: nil),
                  (time: FixedDate(150), index: nil),
                  (time: FixedDate(155), index: nil),
              ])
        func firstIndexGreaterThanSlice(_ test: (time: FixedDate, index: Int?)) throws {
            let series = seriesSecond[2 ... 3]
            #expect(series.firstIndex(greater: test.time) == test.index)
        }

        @Test("First Index withTimeOffsetGreaterThan for one item series")
        func firstIndexGreaterThanOfOne() throws {
            let series = seriesOne
            #expect(series.firstIndex(greater: FixedDate(0)) == 0)
            #expect(series.firstIndex(greater: FixedDate(100)) == 0)
            #expect(series.firstIndex(greater: FixedDate(110)) == nil)
            #expect(series.firstIndex(greater: FixedDate(120)) == nil)
        }

        @Test("First Index withTimeOffsetGreaterThan for empty series")
        func firstIndexGreaterThan() throws {
            let series = emptySeries

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

            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.firstIndex(greaterOrEqual: time) == test.index)
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

            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.firstIndex(greaterOrEqual: time) == test.index)
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
            let series = seriesSecond[2 ... 3]

            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: test.offset) == test.index)

            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.firstIndex(greaterOrEqual: time) == test.index)
        }

        @Test("First Index withTimeOffsetGreaterOrEqualThan for one item series")
        func firstIndexGreaterOrEqualThanOfOne() throws {
            let series = seriesOne

            #expect(series.firstIndex(greaterOrEqual: FixedDate(0)) == 0)
            #expect(series.firstIndex(greaterOrEqual: FixedDate(100)) == 0)
            #expect(series.firstIndex(greaterOrEqual: FixedDate(110)) == 0)
            #expect(series.firstIndex(greaterOrEqual: FixedDate(120)) == nil)
        }

        @Test("First Index withTimeOffsetGreaterOrEqualThan for empty series")
        func firstIndexGreaterOrEqualThan() throws {
            let series = emptySeries

            #expect(series.firstIndex(greaterOrEqual: FixedDate(0)) == nil)
            #expect(series.firstIndex(greaterOrEqual: FixedDate(100)) == nil)
            #expect(series.firstIndex(greaterOrEqual: FixedDate(110)) == nil)
            #expect(series.firstIndex(greaterOrEqual: FixedDate(120)) == nil)
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

            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.lastIndex(less: time) == test.index)
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

            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.lastIndex(less: time) == test.index)
        }

        @Test("Last Index withTimeOffsetLessThan for series of one")
        func lastIndexLessThanOfOne() throws {
            let series = seriesOne

            #expect(series.lastIndex(withTimeOffsetLessThan: 0) == nil)
            #expect(series.lastIndex(withTimeOffsetLessThan: 10) == nil)
            #expect(series.lastIndex(withTimeOffsetLessThan: 20) == 0)

            #expect(series.lastIndex(less: FixedDate(0)) == nil)
            #expect(series.lastIndex(less: FixedDate(100)) == nil)
            #expect(series.lastIndex(less: FixedDate(110)) == nil)
            #expect(series.lastIndex(less: FixedDate(120)) == 0)
        }

        @Test("Last Index withTimeOffsetLessThan for empty series")
        func lastIndexLessThan() throws {
            let series = emptySeries
            #expect(series.lastIndex(withTimeOffsetLessThan: 0) == nil)
            #expect(series.lastIndex(withTimeOffsetLessThan: 10) == nil)
            #expect(series.lastIndex(withTimeOffsetLessThan: 20) == nil)

            #expect(series.lastIndex(less: FixedDate(0)) == nil)
            #expect(series.lastIndex(less: FixedDate(100)) == nil)
            #expect(series.lastIndex(less: FixedDate(110)) == nil)
            #expect(series.lastIndex(less: FixedDate(120)) == nil)
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

            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.lastIndex(lessOrEqual: time) == test.index)
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

            let time = series.timeBase.adding(milliseconds: test.offset)
            #expect(series.lastIndex(lessOrEqual: time) == test.index)
        }

        @Test("Last Index withTimeOffsetLessOrEqualThan for series of one")
        func lastIndexLessOrEqualThanOfOne() throws {
            let series = seriesOne

            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 0) == nil)
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 10) == 0)
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 20) == 0)

            #expect(series.lastIndex(lessOrEqual: FixedDate(0)) == nil)
            #expect(series.lastIndex(lessOrEqual: FixedDate(100)) == nil)
            #expect(series.lastIndex(lessOrEqual: FixedDate(110)) == 0)
            #expect(series.lastIndex(lessOrEqual: FixedDate(120)) == 0)
        }

        @Test("Last Index withTimeOffsetLessOrEqualThan for empty series")
        func lastIndexLessOrEqualThan() throws {
            let series = emptySeries
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 0) == nil)
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 10) == nil)
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: 20) == nil)

            #expect(series.lastIndex(lessOrEqual: FixedDate(0)) == nil)
            #expect(series.lastIndex(lessOrEqual: FixedDate(100)) == nil)
            #expect(series.lastIndex(lessOrEqual: FixedDate(110)) == nil)
            #expect(series.lastIndex(lessOrEqual: FixedDate(120)) == nil)
        }
    }
}
