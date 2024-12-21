//
//  TimeSeriesAdapterTests.swift
//  Stocks
//
//  Created by Vitali Kurlovich on 20.12.24.
//

import Testing
import TimeSeries

struct TimeSeriesAdapterTests {
    @Test("TimeSeriesAdapter")
    func convert() {
        let series = TimeSeries(timeBase: FixedDate(200), items: ticks)
        let converter = Converter()

        let adapter = TimeSeriesAdapter(converter: converter, series: series)

        #expect(adapter.indices == 0 ..< 5)
        #expect(adapter.index(before: 1) == 0)

        let result = Array(adapter)

        let expected = [
            "220 [4, 5]",
            "225 [14, 15]",
            "230 [10, 2]",
            "240 [10, 2]",
            "250 [1, 20]",
        ]

        #expect(result == expected)
    }

    @Test("TimeSeriesAdapter slice by index range")
    func convertSubrange() {
        let series = TimeSeries(timeBase: FixedDate(200), items: ticks)
        let converter = Converter()

        let adapter = TimeSeriesAdapter(converter: converter, series: series)

        let adapterSlice = adapter[1 ... 3]

        let resultSubrange = Array(adapterSlice)

        let expectedSubrange = [
            "225 [14, 15]",
            "230 [10, 2]",
            "240 [10, 2]",
        ]

        #expect(resultSubrange == expectedSubrange)
    }

    @Test("TimeSeriesAdapter slice by DateInterval")
    func convertSubrangeDateInterval() {
        let series = TimeSeries(timeBase: FixedDate(200), items: ticks)
        let converter = Converter()

        let adapter = TimeSeriesAdapter(converter: converter, series: series)

        let dateInterval = FixedDateInterval(start: FixedDate(225), end: FixedDate(240))

        let adapterSlice = adapter[dateInterval]

        let resultSubrange = Array(adapterSlice)

        let expectedSubrange = [
            "225 [14, 15]",
            "230 [10, 2]",
            "240 [10, 2]",
        ]

        #expect(resultSubrange == expectedSubrange)
    }
}

extension TimeSeriesAdapterTests {
    private var ticks: [TestTick] {
        [
            .init(time: 20, ask: 4, bid: 5),
            .init(time: 25, ask: 14, bid: 15),
            .init(time: 30, ask: 10, bid: 2),
            .init(time: 40, ask: 10, bid: 2),
            .init(time: 50, ask: 1, bid: 20),
        ]
    }
}
