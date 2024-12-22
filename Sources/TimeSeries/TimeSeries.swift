//
//  TimeSeries.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 10.12.24.
//

public struct TimeSeries<Element: TimeSeriesItem>: TimeSeriesCollection, Hashable, Sendable {
    public let timeBase: FixedDate
    private var items: [Element]

    public init(timeBase: FixedDate, items: [Element]) {
        assert(items.isTimeValueIncrease)
        self.timeBase = timeBase
        self.items = items
    }

    public static var empty: Self { Self(timeBase: .zero, items: []) }
}

extension TimeSeries: RandomAccessCollection {
    public typealias Index = Array<Element>.Index
    public typealias Indices = Array<Element>.Indices
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

    public subscript(_ range: Range<Self.Index>) -> Self.SubSequence {
        SubSequence(timeBase: timeBase, items: items[range])
    }
}

public
extension TimeSeries {
    init<S: TimeSeriesCollection>(_ series: S) where S.Element == Self.Element {
        self.init(timeBase: series.timeBase, items: Array(series))
    }
}

extension TimeSeries: MutableTimeSeriesCollection {
    public mutating
    func updateOrInsert(_ item: Self.Element) {
        if items.isEmpty {
            items.append(item)
            return
        }

        let index = firstIndex(withTimeGreaterThan: item.time)

        let beforeIndex = items.index(before: index)

        if items.indices.contains(beforeIndex) {
            if items[beforeIndex].time == item.time {
                items[beforeIndex] = item
            } else {
                items.insert(item, at: index)
            }
        } else if index == startIndex {
            items.insert(item, at: startIndex)
        }
    }
}
