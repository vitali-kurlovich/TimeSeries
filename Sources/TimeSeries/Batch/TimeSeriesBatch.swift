//
//  TimeSeriesBatch.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 15.12.24.
//

public struct TimeSeriesBatch<Series: TimeSeriesCollection>: Hashable, Sendable
    where Series: Hashable & Sendable,
    Series.SubSequence: Hashable & Sendable,
    Series.Index: AdditiveArithmetic & BinaryInteger
{
    let batches: [Series]
}

extension TimeSeriesBatch: RandomAccessCollection {
    public typealias Index = Series.Index
    public typealias Element = (Series, Series.Index)

    public var startIndex: Index {
        .zero
    }

    public var endIndex: Index {
        batches.reduce(startIndex) { partialResult, series in
            partialResult + (series.endIndex - series.startIndex)
        }
    }

    public func index(after i: Index) -> Index {
        i + 1
    }

    public func index(before i: Index) -> Index {
        i - 1
    }

    public subscript(position: Series.Index) -> Element {
        var position = position

        for series in batches {
            let index = series.index(series.startIndex, offsetBy: Int(position))

            if series.indices.contains(index) {
                return (series, index)
            }

            position -= (series.endIndex - series.startIndex)
        }

        fatalError()
    }
}
