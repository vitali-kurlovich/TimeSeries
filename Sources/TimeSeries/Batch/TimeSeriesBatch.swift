//
//  TimeSeriesBatch.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 15.12.24.
//

public struct TimeSeriesBatch<Batches: RandomAccessCollection>: Sendable
    where
    Batches: Sendable,
    Batches.Element: TimeSeriesCollection,
    Batches.SubSequence: Sendable,
    Batches.Element.SubSequence: Sendable
{
    private let batches: Batches

    public init(_ batches: Batches) {
        assert(batches.isTimeRangeIncrease)
        self.batches = batches
    }
}

extension TimeSeriesBatch: TimeSeriesCollectionBatch {
    public typealias SubSequenceBatch = TimeSeriesBatch<[Batches.Element.SubSequence]>

    public var timeRange: FixedDateInterval? {
        let ranges = batches.compactMap {
            $0.timeRange
        }

        guard let start = ranges.first?.start,
              let end = ranges.last?.end
        else {
            return nil
        }

        return FixedDateInterval(start: start, end: end)
    }

    public subscript(_ range: FixedDateInterval) -> SubSequenceBatch {
        let batches = batches.lazy.map {
            $0[range]
        }.filter {
            !$0.isEmpty
        }
        return .init(Array(batches))
    }
}

extension TimeSeriesBatch: RandomAccessCollection {
    public typealias Index = Batches.Index
    public typealias Element = Batches.Element
    public typealias SubSequence = TimeSeriesBatch<Batches.SubSequence>

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

    public subscript(_ range: Range<Self.Index>) -> Self.SubSequence {
        SubSequence(batches[range])
    }
}
