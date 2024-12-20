//
//  TimeSeriesBatchAdapterTests.swift
//  Stocks
//
//  Created by Vitali Kurlovich on 20.12.24.
//

import Testing
import TimeSeries

struct TimeSeriesBatchAdapterTests {
    @Test("TimeSeriesBatchAdapter")
    func convert() {
        let batch = TimeSeriesBatch(series)
        let converter = Converter()

        let adapter = TimeSeriesBatchAdapter(converter: converter, batch: batch)

        #expect(adapter.indices == 0 ..< 13)
        #expect(adapter.index(before: 1) == 0)

        let result = Array(adapter)

        let expected = [
            "120 [4, 5]",
            "125 [14, 15]",
            "130 [10, 2]",
            "140 [10, 2]",
            "150 [1, 20]",

            "220 [4, 5]",
            "225 [14, 15]",
            "230 [10, 2]",

            "330 [10, 2]",
            "340 [10, 2]",
            "350 [1, 20]",
            "360 [1, 20]",
            "370 [1, 20]",
        ]

        #expect(result == expected)
    }
}

extension TimeSeriesBatchAdapterTests {
    private var series: [TimeSeries<TestTick>] {
        [
            TimeSeries(timeBase: FixedDate(100), items: ticks_1),
            TimeSeries(timeBase: FixedDate(200), items: ticks_2),
            TimeSeries(timeBase: FixedDate(300), items: ticks_3),
        ]
    }

    private var ticks_1: [TestTick] {
        [
            .init(time: 20, ask: 4, bid: 5),
            .init(time: 25, ask: 14, bid: 15),
            .init(time: 30, ask: 10, bid: 2),
            .init(time: 40, ask: 10, bid: 2),
            .init(time: 50, ask: 1, bid: 20),
        ]
    }

    private var ticks_2: [TestTick] {
        [
            .init(time: 20, ask: 4, bid: 5),
            .init(time: 25, ask: 14, bid: 15),
            .init(time: 30, ask: 10, bid: 2),
        ]
    }

    private var ticks_3: [TestTick] {
        [
            .init(time: 30, ask: 10, bid: 2),
            .init(time: 40, ask: 10, bid: 2),
            .init(time: 50, ask: 1, bid: 20),
            .init(time: 60, ask: 1, bid: 20),
            .init(time: 70, ask: 1, bid: 20),
        ]
    }
}
