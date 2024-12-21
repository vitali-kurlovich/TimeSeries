//
//  TimeSeriesBatchAdapter.swift
//  Stocks
//
//  Created by Vitali Kurlovich on 20.12.24.
//

public struct TimeSeriesBatchAdapter<Converter: TimeSeriesConverter & Sendable, Batch: TimeSeriesBatchProtocol>: Sendable
    where

    Batch.Index == Int,
    Batch.Element.Index == Int,
    Converter.Input == Batch.Element.Element,
    Batch: Sendable,
    Batch.SubSequence: Sendable
{
    public typealias SubSequenceBatch = Batch.SubSequenceBatch

    public let batch: Batch
    public let converter: Converter

    public init(converter: Converter, batch: Batch) {
        self.converter = converter
        self.batch = batch
    }
}

extension TimeSeriesBatchAdapter: RandomAccessCollection {
    public typealias Element = Converter.Output

    public typealias Index = Int
    public typealias Indices = Range<Index>
    public typealias SubSequence = TimeSeriesBatchAdapter<Converter, Batch.SubSequence>

    public var indices: Indices {
        startIndex ..< endIndex
    }

    public var startIndex: Index {
        0
    }

    public var endIndex: Index {
        batch.reduce(startIndex) { partialResult, series in
            partialResult + (series.endIndex - series.startIndex)
        }
    }

    public func index(before i: Index) -> Index {
        i - 1
    }

    public func index(after i: Index) -> Index {
        i + 1
    }

    public subscript(position: Index) -> Element {
        var position = position
        for series in batch {
            position += series.startIndex

            if series.indices.contains(position) {
                let item = series[position]
                let date = series.dateTime(at: position)
                return converter.convert(date: date, input: item)
            }

            position -= series.endIndex
        }
        fatalError()
    }

    public subscript(_ range: Range<Self.Index>) -> Self.SubSequence {
        let batch = batch[range]
        return SubSequence(converter: converter, batch: batch)
    }

    public subscript(_ range: FixedDateInterval) -> TimeSeriesBatchAdapter<Converter, SubSequenceBatch>
        where
        SubSequenceBatch.Index == Int,
        SubSequenceBatch.Element.Index == Int,
        Converter.Input == SubSequenceBatch.Element.Element,
        SubSequenceBatch: Sendable,
        SubSequenceBatch.SubSequence: Sendable
    {
        let subBatch = batch[range]
        return .init(converter: converter, batch: subBatch)
    }
}
