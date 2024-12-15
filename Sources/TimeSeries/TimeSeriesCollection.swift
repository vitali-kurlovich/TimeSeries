//
//  TimeSeriesCollection.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 13.12.24.
//

import Algorithms

public protocol TimeSeriesCollection: RandomAccessCollection
    where Element: TimeSeriesItem,
    SubSequence: TimeSeriesCollection
{
    var timeBase: FixedDate { get }

    static var empty: Self { get }
}

public
extension TimeSeriesCollection {
    var timeRange: FixedDateInterval? {
        if isEmpty {
            return nil
        }

        let start = dateTime(at: startIndex)
        let end = dateTime(at: index(before: endIndex))

        return FixedDateInterval(start: start, end: end)
    }
}

public
extension TimeSeriesCollection {
    func dateTime(at index: Index) -> FixedDate {
        let time = self[index].time
        return timeBase.adding(milliseconds: time)
    }

    subscript(_ range: FixedDateInterval) -> Self.SubSequence {
        guard let timeRange, timeRange.intersects(range) else {
            return .empty
        }

        let start = partitioningIndex { item in
            let date = timeBase.adding(milliseconds: item.time)
            return range.start <= date
        }

        let end = partitioningIndex { item in
            let date = timeBase.adding(milliseconds: item.time)
            return date > range.end
        }

        return self[start ..< end]
    }
}
