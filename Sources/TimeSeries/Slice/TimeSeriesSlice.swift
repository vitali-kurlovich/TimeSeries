//
//  TimeSeriesSlice.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 10.12.24.
//

import Foundation

public struct TimeSeriesSlice<Element: TimeSeriesItem>: TimeSeriesCollection, Hashable, Sendable {
    public let timeBase: FixedDate
    private let items: ArraySlice<Element>

    public init(timeBase: FixedDate, items: ArraySlice<Element>) {
        assert(items.isTimeValueIncrease)

        self.timeBase = timeBase
        self.items = items
    }

    public static var empty: Self { Self(timeBase: .zero, items: []) }
}

extension TimeSeriesSlice: RandomAccessCollection {
    public typealias Index = ArraySlice<Element>.Index
    public typealias Indices = ArraySlice<Element>.Indices
    public typealias SubSequence = TimeSeriesSlice<Element>

    public var indices: Indices {
        items.indices
    }

    public var startIndex: Index {
        items.startIndex
    }

    public var endIndex: Index {
        items.endIndex
    }

    public func index(before i: Index) -> Index {
        items.index(before: i)
    }

    public func index(after i: Index) -> Index {
        items.index(after: i)
    }

    public subscript(position: Index) -> Element {
        items[position]
    }

    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        SubSequence(timeBase: timeBase, items: items[bounds])
    }
}
