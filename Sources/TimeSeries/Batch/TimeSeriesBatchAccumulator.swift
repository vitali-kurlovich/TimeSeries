//
//  TimeSeriesBatchAccumulator.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 23.12.24.
//

public
struct TimeSeriesBatchAccumulator<Element: TimeSeriesItem>: Hashable, Sendable {
    public let batchSize: Int

    private var batches: [TimeSeries<Element>] = []
    private var lastSeries: TimeSeries<Element>?

    public init(batchSize: Int = 128) {
        assert(batchSize >= 8)
        self.batchSize = batchSize
    }
}

public
extension TimeSeriesBatchAccumulator {
    mutating
    func updateOrInsert(timeBase: FixedDate, item: Element) {
        let timeBase = timeBase.adding(milliseconds: item.time)
        let item = item.setTime(0)

        guard var lastSeries else {
            var lastSeries = TimeSeries(timeBase: timeBase, items: [item])
            lastSeries.reserveCapacity(batchSize)
            self.lastSeries = lastSeries
            return
        }

        self.lastSeries = nil

        guard lastSeries.timeBase <= timeBase else {
            // TODO: update batch series
            return
        }

        if lastSeries.timeBase == timeBase {
            lastSeries.updateOrInsert(item)
        } else {
            let timeOffset = lastSeries.timeBase.millisecondsSince(timeBase)
            // TODO: Assert for overflow
            let time = item.time + Element.IntegerTime(timeOffset)
            let item = item.setTime(time)

            lastSeries.updateOrInsert(item)
        }

        if lastSeries.count < batchSize {
            self.lastSeries = lastSeries
        } else {
            batches.append(lastSeries)
        }
    }
}

public
extension TimeSeriesBatchAccumulator {
    func batch() -> TimeSeriesBatch<[TimeSeries<Element>]> {
        if let lastSeries, !lastSeries.isEmpty {
            return .init(batches + [lastSeries])
        }

        return .init(batches)
    }
}
