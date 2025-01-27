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
                  (time: FixedDate(145), index: nil),
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
                  (time: FixedDate(155), index: nil),
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

        @Test("First Index greater",
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

        @Test("First Index greater",
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

        @Test("First Index greater for one item series")
        func firstIndexGreaterThanOfOne() throws {
            let series = seriesOne
            #expect(series.firstIndex(greater: FixedDate(0)) == 0)
            #expect(series.firstIndex(greater: FixedDate(100)) == 0)
            #expect(series.firstIndex(greater: FixedDate(110)) == nil)
            #expect(series.firstIndex(greater: FixedDate(120)) == nil)
        }

        @Test("First Index greater for empty series")
        func firstIndexGreaterThan() throws {
            let series = emptySeries

            #expect(series.firstIndex(greater: FixedDate(0)) == nil)
            #expect(series.firstIndex(greater: FixedDate(100)) == nil)
            #expect(series.firstIndex(greater: FixedDate(110)) == nil)
            #expect(series.firstIndex(greater: FixedDate(120)) == nil)
        }

        @Test("First Index greaterOrEqual",
              arguments: [
                  (time: FixedDate(105), index: 0), // 10
                  (time: FixedDate(110), index: 0), // 10
                  (time: FixedDate(115), index: 1), // 20
                  (time: FixedDate(120), index: 1), // 20
                  (time: FixedDate(125), index: 2), // 30
                  (time: FixedDate(130), index: 2), // 30
                  (time: FixedDate(135), index: 3), // 40
                  (time: FixedDate(140), index: 3), // 40
                  (time: FixedDate(145), index: nil),

              ])
        func firstIndexGreaterOrEqualThan(_ test: (time: FixedDate, index: Int?)) throws {
            let series = self.series

            #expect(series.firstIndex(greaterOrEqual: test.time) == test.index)
        }

        @Test("First Index greaterOrEqual",
              arguments: [
                  (time: FixedDate(105), index: 0), // 10
                  (time: FixedDate(110), index: 0), // 10
                  (time: FixedDate(115), index: 1), // 20
                  (time: FixedDate(120), index: 1), // 20
                  (time: FixedDate(125), index: 2), // 30
                  (time: FixedDate(130), index: 2), // 30
                  (time: FixedDate(135), index: 3), // 40
                  (time: FixedDate(140), index: 3), // 40
                  (time: FixedDate(145), index: 4), // 50
                  (time: FixedDate(150), index: 4), // 50
                  (time: FixedDate(155), index: nil),
              ])
        func firstIndexGreaterOrEqualThan_(_ test: (time: FixedDate, index: Int?)) throws {
            let series = seriesSecond
            #expect(series.firstIndex(greaterOrEqual: test.time) == test.index)
        }

        @Test("First Index greaterOrEqual silec[2...3]",
              arguments: [
                  (time: FixedDate(105), index: 2), // 10
                  (time: FixedDate(110), index: 2), // 10
                  (time: FixedDate(115), index: 2), // 20
                  (time: FixedDate(120), index: 2), // 20
                  (time: FixedDate(125), index: 2), // 30
                  (time: FixedDate(130), index: 2), // 30
                  (time: FixedDate(135), index: 3), // 40
                  (time: FixedDate(140), index: 3), // 40
                  (time: FixedDate(145), index: nil), // 50
                  (time: FixedDate(150), index: nil), // 50
                  (time: FixedDate(155), index: nil),
              ])
        func firstIndexGreaterOrEqualThanSlice(_ test: (time: FixedDate, index: Int?)) throws {
            let series = seriesSecond[2 ... 3]
            #expect(series.firstIndex(greaterOrEqual: test.time) == test.index)
        }

        @Test("First Index greaterOrEqual for one item series")
        func firstIndexGreaterOrEqualThanOfOne() throws {
            let series = seriesOne

            #expect(series.firstIndex(greaterOrEqual: FixedDate(0)) == 0)
            #expect(series.firstIndex(greaterOrEqual: FixedDate(100)) == 0)
            #expect(series.firstIndex(greaterOrEqual: FixedDate(110)) == 0)
            #expect(series.firstIndex(greaterOrEqual: FixedDate(120)) == nil)
        }

        @Test("First Index greaterOrEqual for empty series")
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

        @Test("Last Index less",
              arguments: [
                  (time: FixedDate(105), index: nil),
                  (time: FixedDate(110), index: nil),
                  (time: FixedDate(115), index: 0), // 10
                  (time: FixedDate(120), index: 0), // 10
                  (time: FixedDate(125), index: 1), // 20
                  (time: FixedDate(130), index: 1), // 20
                  (time: FixedDate(135), index: 2), // 30
                  (time: FixedDate(140), index: 2), // 30
                  (time: FixedDate(145), index: 3), // 40

              ])
        func lastIndexLess(_ test: (time: FixedDate, index: Int?)) throws {
            let series = self.series
            #expect(series.lastIndex(less: test.time) == test.index)
        }

        @Test("Last Index less",
              arguments: [
                  (time: FixedDate(105), index: nil),
                  (time: FixedDate(110), index: nil),
                  (time: FixedDate(115), index: 0), // 10
                  (time: FixedDate(120), index: 0), // 10
                  (time: FixedDate(125), index: 1), // 20
                  (time: FixedDate(130), index: 1), // 20
                  (time: FixedDate(135), index: 2), // 30
                  (time: FixedDate(140), index: 2), // 30
                  (time: FixedDate(145), index: 3), // 40
                  (time: FixedDate(150), index: 3), // 40
                  (time: FixedDate(155), index: 4), // 50
              ])
        func lastIndexLess_(_ test: (time: FixedDate, index: Int?)) throws {
            let series = seriesSecond
            #expect(series.lastIndex(less: test.time) == test.index)
        }

        @Test("Last Index less slice[2..3]",
              arguments: [
                  (time: FixedDate(105), index: nil),
                  (time: FixedDate(110), index: nil),
                  (time: FixedDate(115), index: nil),
                  (time: FixedDate(120), index: nil),
                  (time: FixedDate(125), index: nil),
                  (time: FixedDate(130), index: nil),
                  (time: FixedDate(135), index: 2), // 130
                  (time: FixedDate(140), index: 2), // 130
                  (time: FixedDate(145), index: 3), // 140
                  (time: FixedDate(150), index: 3), // 140
                  (time: FixedDate(155), index: 3), // 140
              ])
        func lastIndexLessSlice(_ test: (time: FixedDate, index: Int?)) throws {
            let series = seriesSecond[2 ... 3]
            #expect(series.lastIndex(less: test.time) == test.index)
        }

        @Test("Last Index less for series of one")
        func lastIndexLessOfOne() throws {
            let series = seriesOne

            #expect(series.lastIndex(less: FixedDate(0)) == nil)
            #expect(series.lastIndex(less: FixedDate(100)) == nil)
            #expect(series.lastIndex(less: FixedDate(110)) == nil)
            #expect(series.lastIndex(less: FixedDate(120)) == 0)
        }

        @Test("Last Index less for empty series")
        func lastIndexLess() throws {
            let series = emptySeries

            #expect(series.lastIndex(less: FixedDate(0)) == nil)
            #expect(series.lastIndex(less: FixedDate(100)) == nil)
            #expect(series.lastIndex(less: FixedDate(110)) == nil)
            #expect(series.lastIndex(less: FixedDate(120)) == nil)
        }

        @Test("Last Index lessOrEqual",
              arguments: [
                  (time: FixedDate(105), index: nil),
                  (time: FixedDate(110), index: 0), // 10
                  (time: FixedDate(115), index: 0), // 10
                  (time: FixedDate(120), index: 1), // 20
                  (time: FixedDate(125), index: 1), // 20
                  (time: FixedDate(130), index: 2), // 30
                  (time: FixedDate(135), index: 2), // 30
                  (time: FixedDate(140), index: 3), // 40
                  (time: FixedDate(145), index: 3), // 40
              ])
        func lastIndexLessOrEqualThan(_ test: (time: FixedDate, index: Int?)) throws {
            let series = self.series
            #expect(series.lastIndex(lessOrEqual: test.time) == test.index)
        }

        @Test("First Index lessOrEqual",
              arguments: [
                  (time: FixedDate(105), index: nil),
                  (time: FixedDate(110), index: 0), // 10
                  (time: FixedDate(115), index: 0), // 10
                  (time: FixedDate(120), index: 1), // 20
                  (time: FixedDate(125), index: 1), // 20
                  (time: FixedDate(130), index: 2), // 30
                  (time: FixedDate(135), index: 2), // 30
                  (time: FixedDate(140), index: 3), // 40
                  (time: FixedDate(145), index: 3), // 40
                  (time: FixedDate(150), index: 4), // 50
                  (time: FixedDate(155), index: 4), // 50

              ])
        func lastIndexLessOrEqualThan_(_ test: (time: FixedDate, index: Int?)) throws {
            let series = seriesSecond
            #expect(series.lastIndex(lessOrEqual: test.time) == test.index)
        }

        @Test("First Index lessOrEqual slice[2...3]",
              arguments: [
                  (time: FixedDate(105), index: nil),
                  (time: FixedDate(110), index: nil),
                  (time: FixedDate(115), index: nil),
                  (time: FixedDate(120), index: nil),
                  (time: FixedDate(125), index: nil),
                  (time: FixedDate(130), index: 2), // 130
                  (time: FixedDate(135), index: 2), // 130
                  (time: FixedDate(140), index: 3), // 140
                  (time: FixedDate(145), index: 3), // 140
                  (time: FixedDate(150), index: 3), // 140
                  (time: FixedDate(155), index: 3), // 140

              ])
        func lastIndexLessOrEqualSlice(_ test: (time: FixedDate, index: Int?)) throws {
            let series = seriesSecond[2 ... 3]
            #expect(series.lastIndex(lessOrEqual: test.time) == test.index)
        }

        @Test("Last Index lessOrEqual for series of one")
        func lastIndexLessOrEqualOfOne() throws {
            let series = seriesOne

            #expect(series.lastIndex(lessOrEqual: FixedDate(0)) == nil)
            #expect(series.lastIndex(lessOrEqual: FixedDate(100)) == nil)
            #expect(series.lastIndex(lessOrEqual: FixedDate(110)) == 0)
            #expect(series.lastIndex(lessOrEqual: FixedDate(120)) == 0)
        }

        @Test("Last Index lessOrEqual for empty series")
        func lastIndexLessOrEqualThan() throws {
            let series = emptySeries

            #expect(series.lastIndex(lessOrEqual: FixedDate(0)) == nil)
            #expect(series.lastIndex(lessOrEqual: FixedDate(100)) == nil)
            #expect(series.lastIndex(lessOrEqual: FixedDate(110)) == nil)
            #expect(series.lastIndex(lessOrEqual: FixedDate(120)) == nil)
        }
    }
}
