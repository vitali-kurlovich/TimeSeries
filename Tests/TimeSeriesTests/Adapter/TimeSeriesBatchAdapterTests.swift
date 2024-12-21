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
            "120 [4, 5]", // 0
            "125 [14, 15]", // 1
            "130 [10, 2]", // 2
            "140 [10, 2]", // 3
            "150 [1, 20]", // 4

            "220 [4, 5]", // 5
            "225 [14, 15]", // 6
            "230 [10, 2]", // 7

            "330 [10, 2]", // 8
            "340 [10, 2]", // 9
            "350 [1, 20]", // 10
            "360 [1, 20]", // 11
            "370 [1, 20]", // 12
        ]

        #expect(result == expected)
    }

    @Test("TimeSeriesAdapter slice by index range")
    func convertSubrange() {
        let batch = TimeSeriesBatch(series)
        let converter = Converter()

        let adapter = TimeSeriesBatchAdapter(converter: converter, batch: batch)

        let adapterSlice = adapter[2 ... 10]

        let resultSubrange = Array(adapterSlice)

        let expectedSubrange = [
            "130 [10, 2]", // 2
            "140 [10, 2]", // 3
            "150 [1, 20]", // 4

            "220 [4, 5]", // 5
            "225 [14, 15]", // 6
            "230 [10, 2]", // 7

            "330 [10, 2]", // 8
            "340 [10, 2]", // 9
            "350 [1, 20]", // 10
        ]

        #expect(resultSubrange == expectedSubrange)

        let resultSubSlice = Array(adapterSlice[5 ... 7])

        let expectedSliceSubrange = [
            "220 [4, 5]", // 5
            "225 [14, 15]", // 6
            "230 [10, 2]", // 7
        ]

        #expect(resultSubSlice == expectedSliceSubrange)
    }

    @Test("TimeSeriesAdapter slice by DateInterval")
    func convertSubrangeDateInterval() {
        let batch = TimeSeriesBatch(series)
        let converter = Converter()

        let adapter = TimeSeriesBatchAdapter(converter: converter, batch: batch)

        let dateInterval = FixedDateInterval(start: FixedDate(225), end: FixedDate(240))

        let adapterSlice = adapter[dateInterval]

        let resultSubrange = Array(adapterSlice)

        let expectedSubrange = [
            "225 [14, 15]",
            "230 [10, 2]",
        ]

        #expect(resultSubrange == expectedSubrange)
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
