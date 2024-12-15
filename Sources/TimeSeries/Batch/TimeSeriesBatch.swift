//
//  TimeSeriesBatch.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 15.12.24.
//

public struct TimeSeriesBatch<Series: TimeSeriesCollection>: Hashable, Sendable
    where Series: Hashable & Sendable,
    Series.SubSequence: Hashable & Sendable
{
    private let batches: [Series]

    public init<S: Sequence>(_ batches: S) where S.Element == Series {
        assert(batches.isTimeRangeIncrease)

        let batches = batches.filter { !$0.isEmpty }
        self.batches = batches
    }
}

extension TimeSeriesBatch: RandomAccessCollection {
    public typealias Index = Array<Series>.Index
    public typealias Element = Series

    public var startIndex: Index {
        batches.startIndex
    }

    public var endIndex: Index {
        batches.endIndex
    }

    public func index(after i: Index) -> Index {
        batches.index(after: i)
    }

    public func index(before i: Index) -> Index {
        batches.index(before: i)
    }

    public subscript(position: Index) -> Element {
        batches[position]
    }
}

public
extension TimeSeriesBatch {
    var timeRange: FixedDateInterval? {
        let ranges = batches.compactMap { $0.timeRange }

        guard let start = ranges.first?.start,
              let end = ranges.last?.end
        else {
            return nil
        }

        return FixedDateInterval(start: start, end: end)
    }

    subscript(_ range: FixedDateInterval) -> TimeSeriesBatch<Series.SubSequence> {
        let series = batches.lazy.map {
            $0[range]
        }.filter {
            !$0.isEmpty
        }

        let batches = Array(series)
        return .init(batches)
    }
}
