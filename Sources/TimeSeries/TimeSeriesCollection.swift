//
//  TimeSeriesCollection.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 13.12.24.
//

import Algorithms

public protocol TimeSeriesCollection: RandomAccessCollection, FixedDateTimeBased
    where Element: TimeSeriesItem,
    SubSequence: TimeSeriesCollection
{
    static var empty: Self { get }
}

public
extension TimeSeriesCollection {
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
