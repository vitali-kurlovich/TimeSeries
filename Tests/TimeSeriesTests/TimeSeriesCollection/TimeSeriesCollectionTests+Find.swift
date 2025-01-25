//
//  TimeSeriesCollectionTests+Find.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 24.01.25.
//

import Testing
@testable import TimeSeries

extension TimeSeriesCollectionTests {
    @Suite("Find index")
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
        func firstIndexGreaterThan(_ testData: (offset: Int16, index: Int?)) throws {
            #expect(series.firstIndex(withTimeOffsetGreaterThan: testData.offset) == testData.index)
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
        func firstIndexGreaterThan_(_ testData: (offset: Int16, index: Int?)) throws {
            #expect(seriesSecond.firstIndex(withTimeOffsetGreaterThan: testData.offset) == testData.index)
        }

        @Test("First Index withTimeOffsetGreaterThan for one item series")
        func firstIndexGreaterThanOfOne() throws {
            #expect(seriesOne.firstIndex(withTimeOffsetGreaterThan: 0) == 0)
            #expect(seriesOne.firstIndex(withTimeOffsetGreaterThan: 10) == nil)
            #expect(seriesOne.firstIndex(withTimeOffsetGreaterThan: 20) == nil)
        }

        @Test("First Index withTimeOffsetGreaterThan for empty series")
        func firstIndexGreaterThan() throws {
            #expect(emptySeries.firstIndex(withTimeOffsetGreaterThan: 0) == nil)
            #expect(emptySeries.firstIndex(withTimeOffsetGreaterThan: 10) == nil)
            #expect(emptySeries.firstIndex(withTimeOffsetGreaterThan: 20) == nil)
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
        func firstIndexGreaterOrEqualThan(_ testData: (offset: Int16, index: Int?)) throws {
            #expect(series.firstIndex(withTimeOffsetGreaterOrEqualThan: testData.offset) == testData.index)
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
        func firstIndexGreaterOrEqualThan_(_ testData: (offset: Int16, index: Int?)) throws {
            #expect(seriesSecond.firstIndex(withTimeOffsetGreaterOrEqualThan: testData.offset) == testData.index)
        }

        @Test("First Index withTimeOffsetGreaterOrEqualThan for one item series")
        func firstIndexGreaterOrEqualThanOfOne() throws {
            #expect(seriesOne.firstIndex(withTimeOffsetGreaterOrEqualThan: 0) == 0)
            #expect(seriesOne.firstIndex(withTimeOffsetGreaterOrEqualThan: 10) == 0)
            #expect(seriesOne.firstIndex(withTimeOffsetGreaterOrEqualThan: 20) == nil)
        }

        @Test("First Index withTimeOffsetGreaterOrEqualThan for empty series")
        func firstIndexGreaterOrEqualThan() throws {
            #expect(emptySeries.firstIndex(withTimeOffsetGreaterOrEqualThan: 0) == nil)
            #expect(emptySeries.firstIndex(withTimeOffsetGreaterOrEqualThan: 10) == nil)
            #expect(emptySeries.firstIndex(withTimeOffsetGreaterOrEqualThan: 20) == nil)
        }
    }
}

extension TimeSeriesCollectionTests {
    @Suite("Find index")
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
        func lastIndexLessThan(_ testData: (offset: Int16, index: Int?)) throws {
            #expect(series.lastIndex(withTimeOffsetLessThan: testData.offset) == testData.index)
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
        func lastIndexLessThan_(_ testData: (offset: Int16, index: Int?)) throws {
            #expect(seriesSecond.lastIndex(withTimeOffsetLessThan: testData.offset) == testData.index)
        }

        @Test("Last Index withTimeOffsetLessThan for series of one")
        func lastIndexLessThanOfOne() throws {
            #expect(seriesOne.lastIndex(withTimeOffsetLessThan: 0) == nil)
            #expect(seriesOne.lastIndex(withTimeOffsetLessThan: 10) == nil)
            #expect(seriesOne.lastIndex(withTimeOffsetLessThan: 20) == 0)
        }

        @Test("Last Index withTimeOffsetLessThan for empty series")
        func lastIndexLessThan() throws {
            #expect(emptySeries.lastIndex(withTimeOffsetLessThan: 0) == nil)
            #expect(emptySeries.lastIndex(withTimeOffsetLessThan: 10) == nil)
            #expect(emptySeries.lastIndex(withTimeOffsetLessThan: 20) == nil)
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
        func lastIndexLessOrEqualThan(_ testData: (offset: Int16, index: Int?)) throws {
            #expect(series.lastIndex(withTimeOffsetLessOrEqualThan: testData.offset) == testData.index)
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
        func lastIndexLessOrEqualThan_(_ testData: (offset: Int16, index: Int?)) throws {
            #expect(seriesSecond.lastIndex(withTimeOffsetLessOrEqualThan: testData.offset) == testData.index)
        }

        @Test("Last Index withTimeOffsetLessOrEqualThan for series of one")
        func lastIndexLessOrEqualThanOfOne() throws {
            #expect(seriesOne.lastIndex(withTimeOffsetLessOrEqualThan: 0) == nil)
            #expect(seriesOne.lastIndex(withTimeOffsetLessOrEqualThan: 10) == 0)
            #expect(seriesOne.lastIndex(withTimeOffsetLessOrEqualThan: 20) == 0)
        }

        @Test("Last Index withTimeOffsetLessOrEqualThan for empty series")
        func lastIndexLessOrEqualThan() throws {
            #expect(emptySeries.lastIndex(withTimeOffsetLessOrEqualThan: 0) == nil)
            #expect(emptySeries.lastIndex(withTimeOffsetLessOrEqualThan: 10) == nil)
            #expect(emptySeries.lastIndex(withTimeOffsetLessOrEqualThan: 20) == nil)
        }
    }
}
