//
//  TimeSeriesBatchAccumulator.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 23.12.24.
//

public
struct TimeSeriesBatchAccumulator<Element: TimeSeriesItem>: Hashable, Sendable {
    public let batchSize: Int

    var batches: [TimeSeries<Element>] = []
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
        guard var lastSeries else {
            var lastSeries = TimeSeries(timeBase: timeBase, items: [item])
            lastSeries.reserveCapacity(batchSize)
            self.lastSeries = lastSeries
            return
        }

        self.lastSeries = nil

        defer {
            if lastSeries.count < batchSize {
                self.lastSeries = lastSeries
            } else {
                batches.append(lastSeries)
            }
        }

        guard lastSeries.timeBase <= timeBase else {
            // TODO: update batch series
            guard !batches.isEmpty else {
                var series = TimeSeries(timeBase: timeBase, items: [item])
                series.reserveCapacity(batchSize)
                batches.append(series)
                return
            }

            let date = timeBase.adding(milliseconds: item.time)

            for index in batches.indices.reversed() {
                var series = batches[index]

                let nextIndex = batches.index(after: index)
                let nextTimeBase: FixedDate
                if batches.indices.contains(nextIndex) {
                    let nextSeries = batches[nextIndex]
                    nextTimeBase = nextSeries.timeBase
                } else {
                    nextTimeBase = lastSeries.timeBase
                }

                let range = series.avalibleTimeRange
                let start = range.start
                let end = min(nextTimeBase, range.end)

                let avalibleTimeRange = FixedDateInterval(start: start, end: end)
                let emptyTimeRange = FixedDateInterval(start: end, end: nextTimeBase)

                if avalibleTimeRange.contains(date) {
                    let timeOffset = series.timeBase.millisecondsSince(timeBase)
                    let time = item.time + Element.IntegerTime(timeOffset)
                    let item = item.setTime(time)
                    series.updateOrInsert(item)

                    batches[index] = series
                    return

                } else if emptyTimeRange.contains(date) {
                    var series = TimeSeries(timeBase: timeBase, items: [item])
                    series.reserveCapacity(batchSize)
                    let index = batches.index(after: index)
                    batches.insert(series, at: index)
                    return
                }
            }

            var series = TimeSeries(timeBase: timeBase, items: [item])
            series.reserveCapacity(batchSize)
            batches.insert(series, at: batches.startIndex)

            return
        }

        if lastSeries.timeBase == timeBase {
            lastSeries.updateOrInsert(item)
        } else {
            // TODO: Assert for overflow
            if lastSeries.avalibleTimeRange.contains(timeBase.adding(milliseconds: item.time)) {
                let timeOffset = lastSeries.timeBase.millisecondsSince(timeBase)
                let time = item.time + Element.IntegerTime(timeOffset)
                let item = item.setTime(time)
                lastSeries.updateOrInsert(item)
            } else {
                if !lastSeries.isEmpty {
                    batches.append(lastSeries)
                }

                lastSeries = TimeSeries(timeBase: timeBase, items: [item])
                lastSeries.reserveCapacity(batchSize)
            }
        }
    }
}

extension TimeSeriesBatchAccumulator {
    private mutating
    func _updateOrInsert(timeBase _: FixedDate, item _: Element) {}
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
