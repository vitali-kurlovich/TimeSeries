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
    func firstIndex(withTimeGreaterThan time: Element.IntegerTime) -> Index {
        partitioningIndex { item in
            time < item.time
        }
    }
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

public protocol MutableTimeSeriesCollection: TimeSeriesCollection {
    mutating func updateTimeBase(_ timeBase: FixedDate)

    mutating func reserveCapacity(_ minimumCapacity: Int)

    mutating
    func updateOrInsert(_ item: Self.Element)
}

public
extension MutableTimeSeriesCollection {
    func canUpdateTimeBase(to newTimeBase: FixedDate) -> Bool {
        guard timeBase != newTimeBase, let last, let first else {
            return true
        }

        let offset = timeBase.millisecondsSince(newTimeBase)

        let minTimeValue = Int(Self.Element.IntegerTime.min) + offset
        let maxTimeValue = Int(Self.Element.IntegerTime.max) - offset

        let firstTime = Int(first.time)
        let lastTime = Int(last.time)

        return firstTime < maxTimeValue && lastTime < maxTimeValue && firstTime > minTimeValue && lastTime > minTimeValue
    }
}
