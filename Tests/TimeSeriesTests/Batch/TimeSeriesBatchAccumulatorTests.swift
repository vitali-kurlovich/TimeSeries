//
//  TimeSeriesBatchAccumulatorTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 23.12.24.
//

import Testing
@testable import TimeSeries

struct TimeSeriesBatchAccumulatorTests {
    typealias Series = TimeSeries<MocItem>
    typealias Batch = TimeSeriesBatch<[Series]>

    @Test("Accumulate",
          arguments: [
              TestsData.empty,
              TestsData.oneItem,
              TestsData.items_8,
              TestsData.items_10,
              TestsData.items_10_reverse,
              TestsData.items_overflow,
          ])
    func accumulate(items: [AccumulatorItem]) throws {
        var accumulator = TimeSeriesBatchAccumulator<MocItem>(batchSize: 8)

        for item in items {
            accumulator.updateOrInsert(timeBase: item.timeBase, item: item.item)
        }

        let expected = items.map { MocDateItem($0) }.sorted()

        let converter = MocConverter()

        let batch = accumulator.batch()

        let adapter = TimeSeriesBatchAdapter(converter: converter, batch: batch)

        #expect(Array(adapter) == Array(expected))

        if items.count > 2 {
            #expect(batch.count < expected.count)
        }
    }
}

struct AccumulatorItem: Comparable {
    let timeBase: FixedDate
    let item: MocItem

    static func < (lhs: AccumulatorItem, rhs: AccumulatorItem) -> Bool {
        lhs.timeBase.adding(milliseconds: lhs.item.time) < rhs.timeBase.adding(milliseconds: rhs.item.time)
    }
}

struct MocDateItem: Comparable, Equatable {
    let date: FixedDate
    let index: Int

    static func < (lhs: MocDateItem, rhs: MocDateItem) -> Bool {
        lhs.date < rhs.date
    }
}

extension MocDateItem {
    init(timeBase: FixedDate, item: MocItem) {
        let date = timeBase.adding(milliseconds: item.time)
        self.init(date: date, index: item.index)
    }

    init(_ item: AccumulatorItem) {
        self.init(timeBase: item.timeBase, item: item.item)
    }
}

struct MocConverter: TimeSeriesConverter {
    typealias Input = MocItem
    typealias Output = MocDateItem

    func convert(date: FixedDate, input: Input) -> Output {
        return MocDateItem(date: date, index: input.index)
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
            .init(timeBase: FixedDate(200), item: .init(time: 32767, index: 5)),
            .init(timeBase: FixedDate(200), item: .init(time: 70, index: 6)),
            .init(timeBase: FixedDate(200), item: .init(time: 80, index: 7)),
            .init(timeBase: FixedDate(200), item: .init(time: 90, index: 8)),
            .init(timeBase: FixedDate(300), item: .init(time: 100, index: 9)),
        ]
    }
}

// 32767
