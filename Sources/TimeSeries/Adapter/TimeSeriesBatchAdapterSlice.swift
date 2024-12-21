//
//  TimeSeriesBatchAdapterSlice.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 21.12.24.
//

public struct TimeSeriesBatchAdapterSlice<Adapter: RandomAccessCollection>: Sendable
    where
    Adapter.Index == Int,
    Adapter: Sendable
{
    let adapter: Adapter
    let range: Range<Int>

    public init(_ adapter: Adapter, range: Range<Int>) {
        self.adapter = adapter
        self.range = range
    }
}

extension TimeSeriesBatchAdapterSlice: RandomAccessCollection {
    public typealias Element = Adapter.Element
    public typealias Index = Int
    public typealias Indices = Range<Int>

    public typealias SubSequence = TimeSeriesBatchAdapterSlice<Adapter>

    public var startIndex: Index {
        range.lowerBound
    }

    public var endIndex: Index {
        range.upperBound
    }

    public var indices: Indices {
        startIndex ..< endIndex
    }

    public func index(before i: Index) -> Index {
        i - 1
    }

    public func index(after i: Index) -> Index {
        i + 1
    }

    public subscript(position: Index) -> Element {
        adapter[position]
    }

    public subscript(_ range: Range<Self.Index>) -> Self.SubSequence {
        SubSequence(adapter, range: range)
    }
}
