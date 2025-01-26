//
//  TimeSeriesCollection+IndexByDate.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 25.01.25.
//

internal
extension TimeSeriesCollection {
    func index(with time: FixedDate) -> Index? {
        let offset = timeBase.millisecondsSince(time)

        guard timeOffsetAvalibleRange.contains(offset) else {
            return nil
        }

        return index(with: TimeOffset(offset))
    }

    func firstIndex(greater time: FixedDate) -> Index? {
        guard let timeRange, timeRange.end > time else {
            return nil
        }

        if timeRange.start > time {
            return startIndex
        }

        let offset = timeBase.millisecondsSince(time)

        return firstIndex(withTimeOffsetGreaterThan: .init(offset))
    }
}
