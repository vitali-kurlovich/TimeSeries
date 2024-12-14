//
//  TimeSeriesSlice.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 10.12.24.
//

import Foundation

public struct TimeSeriesSlice<Item: TimeSeriesItem>: TimeSeriesCollection, Sendable, Hashable {
    public typealias Element = Item
    public typealias Index = ArraySlice<Item>.Index
    public typealias Indices = ArraySlice<Item>.Indices
    public typealias SubSequence = TimeSeriesSlice<Item>

    public let timeBase: FixedDate
    public let items: ArraySlice<Item>

    public init(timeBase: FixedDate, items: ArraySlice<Item>) {
        assert(items.isTimeValueIncrease)

        self.timeBase = timeBase
        self.items = items
    }

    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        SubSequence(timeBase: timeBase, items: items[bounds])
    }

    public static var empty: Self { Self(timeBase: .zero, items: []) }
}
