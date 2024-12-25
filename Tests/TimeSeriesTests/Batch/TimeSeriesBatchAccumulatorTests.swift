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
              (TestsData.empty, TestsData.batchEmpty),
              (TestsData.oneItem, TestsData.batchOfOneItem),
              (TestsData.items_8, TestsData.batchOf_8_Item),
              (TestsData.items_10, TestsData.batchOf_10_Item),
              // (TestsData.items_10_reverse, TestsData.batchOf_10_Item_reverse),
          ])
    func accumulate(items: [AccumulatorItem], expected: Batch) throws {
        var accumulator = TimeSeriesBatchAccumulator<MocItem>(batchSize: 8)

        for item in items {
            accumulator.updateOrInsert(timeBase: item.timeBase, item: item.item)
        }

        #expect(accumulator.batch() == expected)
    }

    @Test("Ordered", arguments: [
        TestsData.oneItem,
        TestsData.items_8,
        TestsData.items_10,
        // TestsData.items_10_reverse,
    ])
    func order(items: [AccumulatorItem]) {
        let converter = MocConverter()

        var accumulator = TimeSeriesBatchAccumulator<MocItem>(batchSize: 8)

        for item in items {
            accumulator.updateOrInsert(timeBase: item.timeBase, item: item.item)
        }

        let sortedItems = items.sorted { left, right in
            left.timeBase.adding(milliseconds: left.item.time) < right.timeBase.adding(milliseconds: right.item.time)
        }

        var accumulatorSorted = TimeSeriesBatchAccumulator<MocItem>(batchSize: 8)

        for item in sortedItems {
            accumulatorSorted.updateOrInsert(timeBase: item.timeBase, item: item.item)
        }

        let adapter = TimeSeriesBatchAdapter(converter: converter, batch: accumulator.batch())
        let adapterSorted = TimeSeriesBatchAdapter(converter: converter, batch: accumulatorSorted.batch())

        #expect(Array(adapter) == Array(adapterSorted))
    }
}

struct AccumulatorItem {
    let timeBase: FixedDate
    let item: MocItem
}

struct MocConverter: TimeSeriesConverter {
    typealias Input = MocItem
    typealias Output = String

    func convert(date: FixedDate, input: Input) -> String {
        let milliseconds = date.millisecondsFrom1970

        return "\(milliseconds):\(input.index)"
    }
}

private enum TestsData {
    typealias Series = TimeSeries<MocItem>
    typealias Batch = TimeSeriesBatch<[Series]>

    static var empty: [AccumulatorItem] {
        []
    }

    static var batchEmpty: Batch {
        Batch([])
    }

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
            .init(timeBase: FixedDate(300), item: .init(time: 100, index: 9)), // 0
            .init(timeBase: FixedDate(200), item: .init(time: 90, index: 8)), // 1
            .init(timeBase: FixedDate(200), item: .init(time: 80, index: 7)), // 2
            .init(timeBase: FixedDate(200), item: .init(time: 70, index: 6)), // 3
            .init(timeBase: FixedDate(200), item: .init(time: 60, index: 5)), // 4
            .init(timeBase: FixedDate(200), item: .init(time: 50, index: 4)), // 5
            .init(timeBase: FixedDate(100), item: .init(time: 40, index: 3)), // 6
            .init(timeBase: FixedDate(100), item: .init(time: 30, index: 2)), // 7

            .init(timeBase: FixedDate(100), item: .init(time: 20, index: 1)), // 8
            .init(timeBase: FixedDate(100), item: .init(time: 10, index: 0)), // 9
        ]
    }

    static var batchOf_10_Item_reverse: Batch {
        Batch([
            .init(timeBase: FixedDate(110), items: [
                .init(time: 0, index: 0),
                .init(time: 10, index: 1),
            ]),

            .init(timeBase: FixedDate(130), items: [
                .init(time: 0, index: 2),
                .init(time: 10, index: 3),
                .init(time: 120, index: 4),
                .init(time: 130, index: 5),
                .init(time: 140, index: 6),
                .init(time: 150, index: 7),
                .init(time: 160, index: 8),
                .init(time: 270, index: 9),
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
