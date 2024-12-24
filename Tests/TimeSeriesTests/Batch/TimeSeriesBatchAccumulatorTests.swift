//
//  TimeSeriesBatchAccumulatorTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 23.12.24.
//

import Testing
import TimeSeries

struct TimeSeriesBatchAccumulatorTests {
    typealias Series = TimeSeries<MocItem>
    typealias Batch = TimeSeriesBatch<[Series]>

    @Test("Accumulate",
          arguments: [
              ([AccumulatorItem](), Batch([])),
              (TestsData.oneItem, TestsData.batchOfOneItem),
              (TestsData.items_8, TestsData.batchOf_8_Item),
              (TestsData.items_10, TestsData.batchOf_10_Item),
          ])
    func accumulate(items: [AccumulatorItem], expected: Batch) throws {
        var accumulator = TimeSeriesBatchAccumulator<MocItem>(batchSize: 8)

        for item in items {
            accumulator.updateOrInsert(timeBase: item.timeBase, item: item.item)
        }

        #expect(accumulator.batch() == expected)
    }
}

struct AccumulatorItem {
    let timeBase: FixedDate
    let item: MocItem
}

private enum TestsData {
    typealias Series = TimeSeries<MocItem>
    typealias Batch = TimeSeriesBatch<[Series]>

    static var oneItem: [AccumulatorItem] {
        [.init(timeBase: FixedDate(100), item: .init(time: 20, index: 0))]
    }

    static var batchOfOneItem: Batch {
        Batch([.init(timeBase: FixedDate(120), items: [.init(time: 0, index: 0)])])
    }

    static var items_8: [AccumulatorItem] {
        [
            .init(timeBase: FixedDate(100), item: .init(time: 10, index: 0)),
            .init(timeBase: FixedDate(100), item: .init(time: 20, index: 1)),
            .init(timeBase: FixedDate(100), item: .init(time: 30, index: 2)),
            .init(timeBase: FixedDate(100), item: .init(time: 40, index: 3)),
            .init(timeBase: FixedDate(200), item: .init(time: 50, index: 4)),
            .init(timeBase: FixedDate(200), item: .init(time: 60, index: 5)),
            .init(timeBase: FixedDate(200), item: .init(time: 70, index: 6)),
            .init(timeBase: FixedDate(200), item: .init(time: 80, index: 7)),
        ]
    }

    static var batchOf_8_Item: Batch {
        Batch([.init(timeBase: FixedDate(110), items:
            [
                .init(time: 0, index: 0),
                .init(time: 10, index: 1),
                .init(time: 20, index: 2),
                .init(time: 30, index: 3),
                .init(time: 140, index: 4),
                .init(time: 150, index: 5),
                .init(time: 160, index: 6),
                .init(time: 170, index: 7),
            ])])
    }

    static var items_10: [AccumulatorItem] {
        [
            .init(timeBase: FixedDate(100), item: .init(time: 10, index: 0)),
            .init(timeBase: FixedDate(100), item: .init(time: 20, index: 1)),
            .init(timeBase: FixedDate(100), item: .init(time: 30, index: 2)),
            .init(timeBase: FixedDate(100), item: .init(time: 40, index: 3)),
            .init(timeBase: FixedDate(200), item: .init(time: 50, index: 4)),
            .init(timeBase: FixedDate(200), item: .init(time: 60, index: 5)),
            .init(timeBase: FixedDate(200), item: .init(time: 70, index: 6)),
            .init(timeBase: FixedDate(200), item: .init(time: 80, index: 7)),
            .init(timeBase: FixedDate(200), item: .init(time: 90, index: 8)),
            .init(timeBase: FixedDate(300), item: .init(time: 100, index: 9)),
        ]
    }

    static var batchOf_10_Item: Batch {
        Batch([
            .init(timeBase: FixedDate(110), items: [
                .init(time: 0, index: 0),
                .init(time: 10, index: 1),
                .init(time: 20, index: 2),
                .init(time: 30, index: 3),
                .init(time: 140, index: 4),
                .init(time: 150, index: 5),
                .init(time: 160, index: 6),
                .init(time: 170, index: 7),
            ]),

            .init(timeBase: FixedDate(290), items: [
                .init(time: 0, index: 8),
                .init(time: 110, index: 9),
            ]),

        ])
    }

    static var items_10_reverse: [AccumulatorItem] {
        [
            .init(timeBase: FixedDate(300), item: .init(time: 100, index: 9)),
            .init(timeBase: FixedDate(200), item: .init(time: 90, index: 8)),
            .init(timeBase: FixedDate(200), item: .init(time: 80, index: 7)),
            .init(timeBase: FixedDate(200), item: .init(time: 70, index: 6)),
            .init(timeBase: FixedDate(200), item: .init(time: 60, index: 5)),
            .init(timeBase: FixedDate(200), item: .init(time: 50, index: 4)),
            .init(timeBase: FixedDate(100), item: .init(time: 40, index: 3)),
            .init(timeBase: FixedDate(100), item: .init(time: 30, index: 2)),
            .init(timeBase: FixedDate(100), item: .init(time: 20, index: 1)),
            .init(timeBase: FixedDate(100), item: .init(time: 10, index: 0)),
        ]
    }

    static var batchOf_10_Item_reverse: Batch {
        Batch([
            .init(timeBase: FixedDate(110), items: [
                .init(time: 0, index: 0),
                .init(time: 10, index: 1),
                .init(time: 20, index: 2),
                .init(time: 30, index: 3),
                .init(time: 140, index: 4),
                .init(time: 150, index: 5),
                .init(time: 160, index: 6),
                .init(time: 170, index: 7),
            ]),

            .init(timeBase: FixedDate(290), items: [
                .init(time: 0, index: 8),
                .init(time: 110, index: 9),
            ]),

        ])
    }

    // Overflow

    static var items_overflow: [AccumulatorItem] {
        [
            .init(timeBase: FixedDate(100), item: .init(time: 32767, index: 0)),
            .init(timeBase: FixedDate(100), item: .init(time: 20, index: 1)),
            .init(timeBase: FixedDate(100), item: .init(time: 30, index: 2)),
            .init(timeBase: FixedDate(100), item: .init(time: 40, index: 3)),
            .init(timeBase: FixedDate(200), item: .init(time: 50, index: 4)),
            .init(timeBase: FixedDate(200), item: .init(time: 60, index: 5)),
            .init(timeBase: FixedDate(200), item: .init(time: 70, index: 6)),
            .init(timeBase: FixedDate(200), item: .init(time: 80, index: 7)),
            .init(timeBase: FixedDate(200), item: .init(time: 90, index: 8)),
            .init(timeBase: FixedDate(300), item: .init(time: 100, index: 9)),
        ]
    }
}

// 32767
