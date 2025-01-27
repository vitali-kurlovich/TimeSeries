//
//  TimeSeriesCollectionTests+Indices.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 27.01.25.
//

import Testing
@testable import TimeSeries

extension TimeSeriesCollectionTests {
    @Suite("Indices")
    struct TimeSeriesCollectionIndices {
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

        @Test("Indices by Range", arguments: [
            (range: FixedDate(0) ..< FixedDate(100), expected: nil),
            (range: FixedDate(100) ..< FixedDate(110), expected: nil),
            (range: FixedDate(110) ..< FixedDate(120), expected: 0 ... 0),
            (range: FixedDate(110) ..< FixedDate(140), expected: 0 ... 2),
            (range: FixedDate(130) ..< FixedDate(150), expected: 2 ... 3),
            (range: FixedDate(130) ..< FixedDate(160), expected: 2 ... 4),
            (range: FixedDate(150) ..< FixedDate(160), expected: 4 ... 4),
            (range: FixedDate(160) ..< FixedDate(170), expected: nil),
        ])
        func range(_ test: (range: Range<FixedDate>, expected: ClosedRange<Int>?)) {
            let series = series
            #expect(series.indices(for: test.range) == test.expected)
        }

        @Test("Indices by ClosedRange", arguments: [
            (range: FixedDate(0) ... FixedDate(100), expected: nil),
            (range: FixedDate(100) ... FixedDate(110), expected: 0 ... 0),
            (range: FixedDate(110) ... FixedDate(120), expected: 0 ... 1),
            (range: FixedDate(110) ... FixedDate(140), expected: 0 ... 3),
            (range: FixedDate(130) ... FixedDate(150), expected: 2 ... 4),
            (range: FixedDate(130) ... FixedDate(160), expected: 2 ... 4),
            (range: FixedDate(150) ... FixedDate(160), expected: 4 ... 4),
            (range: FixedDate(160) ... FixedDate(170), expected: nil),
        ])
        func range(_ test: (range: ClosedRange<FixedDate>, expected: ClosedRange<Int>?)) {
            let series = series
            #expect(series.indices(for: test.range) == test.expected)
        }

        @Test("Indices by PartialRangeFrom", arguments: [
            (range: FixedDate(0)..., expected: 0 ... 4),
            (range: FixedDate(100)..., expected: 0 ... 4),
            (range: FixedDate(110)..., expected: 0 ... 4),
            (range: FixedDate(120)..., expected: 1 ... 4),
            (range: FixedDate(130)..., expected: 2 ... 4),
            (range: FixedDate(140)..., expected: 3 ... 4),
            (range: FixedDate(150)..., expected: 4 ... 4),
            (range: FixedDate(160)..., expected: nil),
        ])
        func range(_ test: (range: PartialRangeFrom<FixedDate>, expected: ClosedRange<Int>?)) {
            let series = series
            #expect(series.indices(for: test.range) == test.expected)
        }

        @Test("Indices by PartialRangeThrough", arguments: [
            (range: ...FixedDate(100), expected: nil),
            (range: ...FixedDate(110), expected: 0 ... 0),
            (range: ...FixedDate(120), expected: 0 ... 1),
            (range: ...FixedDate(130), expected: 0 ... 2),
            (range: ...FixedDate(140), expected: 0 ... 3),
            (range: ...FixedDate(150), expected: 0 ... 4),
            (range: ...FixedDate(160), expected: 0 ... 4),
            (range: ...FixedDate(160), expected: 0 ... 4),
        ])
        func range(_ test: (range: PartialRangeThrough<FixedDate>, expected: ClosedRange<Int>?)) {
            let series = series
            #expect(series.indices(for: test.range) == test.expected)
        }

        // PartialRangeUpTo

        @Test("Indices by PartialRangeUpTo", arguments: [
            (range: ..<FixedDate(100), expected: nil),
            (range: ..<FixedDate(110), expected: nil),
            (range: ..<FixedDate(120), expected: 0 ... 0),
            (range: ..<FixedDate(130), expected: 0 ... 1),
            (range: ..<FixedDate(140), expected: 0 ... 2),
            (range: ..<FixedDate(150), expected: 0 ... 3),
            (range: ..<FixedDate(160), expected: 0 ... 4),
        ])
        func range(_ test: (range: PartialRangeUpTo<FixedDate>, expected: ClosedRange<Int>?)) {
            let series = series
            #expect(series.indices(for: test.range) == test.expected)
        }
    }
}
