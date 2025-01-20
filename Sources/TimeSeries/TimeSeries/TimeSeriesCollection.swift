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
    func split(maxCount: Int) -> [SubSequence] {
        var splitted: [SubSequence] = []
        splitted.reserveCapacity(1 + count / maxCount)

        var startIndex = self.startIndex

        for endIndex in indices.striding(by: maxCount).dropFirst() {
            let rande = startIndex ..< endIndex
            startIndex = endIndex

            let slice = self[rande]
            splitted.append(slice)
        }

        let rande = startIndex ..< endIndex

        if !rande.isEmpty {
            let slice = self[rande]
            splitted.append(slice)
        }

        return splitted
    }
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
