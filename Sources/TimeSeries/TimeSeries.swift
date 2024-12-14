//
//  TimeSeries.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 10.12.24.
//

public struct TimeSeries<Element: TimeSeriesItem>: TimeSeriesCollection, Hashable, Sendable {
    public typealias ItemsSequence = [Element]

    public typealias Index = ItemsSequence.Index
    public typealias Indices = ItemsSequence.Indices

    public typealias SubSequence = TimeSeriesSlice<Element>

    public let timeBase: FixedDate
    public let items: [Element]

    public init(timeBase: FixedDate, items: [Element]) {
        assert(items.isTimeValueIncrease)

        self.timeBase = timeBase
        self.items = items
    }

    public subscript(_ range: Range<Self.Index>) -> Self.SubSequence {
        SubSequence(timeBase: timeBase, items: items[range])
    }

    public static var empty: Self { Self(timeBase: .zero, items: []) }
}

extension TimeSeries {
    init<S: TimeSeriesCollection>(_ series: S) where S.Element == Self.Element {
        let items = Array(series.items)
        self.init(timeBase: series.timeBase, items: items)
    }
}

extension TimeSeries {
    init<S: TimeSeriesCollection>(_ series: S) where S.Element == Self.Element, S.ItemsSequence == [Element] {
        self.init(timeBase: series.timeBase, items: series.items)
    }
}
