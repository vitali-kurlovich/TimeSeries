//
//  Sequence+TimeSeriesCollection.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 15.12.24.
//

public
extension Sequence where Element: TimeSeriesCollection {
    var timeRange: FixedDateInterval? {
        var iterator = makeIterator()
        guard var timeRange = iterator.next()?.timeRange else {
            return nil
        }

        while let series = iterator.next() {
            if let next = series.timeRange {
                timeRange = timeRange.union(next)
            }
        }

        return timeRange
    }
}
