//
//  TimeSeriesCollection.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 13.12.24.
//

import Algorithms

public protocol TimeSeriesCollection: RandomAccessCollection where Element: TimeSeriesItem, SubSequence: TimeSeriesCollection {
    associatedtype ItemsSequence: RandomAccessCollection<Element>

    var timeBase: FixedDate { get }
    var items: ItemsSequence { get }

    static var empty: Self { get }
}

public
extension TimeSeriesCollection {
    var itemsTimeRange: FixedDateInterval? {
        if isEmpty {
            return nil
        }

        let start = dateTime(at: startIndex)
        let end = dateTime(at: index(before: endIndex))

        return FixedDateInterval(start: start, end: end)
    }
}

public extension TimeSeriesCollection
    where Index == ItemsSequence.Index, Indices == ItemsSequence.Indices
{
    var indices: Indices {
        items.indices
    }

    var startIndex: Index {
        items.startIndex
    }

    var endIndex: Index {
        items.endIndex
    }

    func index(before i: Index) -> Index {
        items.index(before: i)
    }

    func index(after i: Index) -> Index {
        items.index(after: i)
    }

    subscript(position: Index) -> Element {
        items[position]
    }
}

public
extension TimeSeriesCollection {
    func dateTime(at index: Index) -> FixedDate {
        let time = self[index].time
        return timeBase.adding(milliseconds: time)
    }

    subscript(_ range: FixedDateInterval) -> Self.SubSequence {
        if isEmpty {
            return .empty
        }

        if range.end < dateTime(at: startIndex) {
            return .empty
        }

        if range.start > dateTime(at: index(before: endIndex)) {
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
