//
//  TimeSeries.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 10.12.24.
//

public struct TimeSeries<Element: TimeSeriesItem>: TimeSeriesCollection, Hashable, Sendable {
    private var items: [Element]
    private var _timeBase: FixedDate

    public init(timeBase: FixedDate, items: [Element]) {
        assert(items.isTimeValueIncrease)
        _timeBase = timeBase
        self.items = items
    }

    public static var empty: Self { Self(timeBase: .zero, items: []) }

    public func setTimeBase(_ newTimeBase: FixedDate) -> Self {
        if timeBase == newTimeBase {
            return self
        }

        if isEmpty {
            return .init(timeBase: newTimeBase, items: [])
        }

        assert(canSetTimeBase(to: newTimeBase))

        let offset = newTimeBase.millisecondsSince(timeBase)

        let timeOffset = Element.IntegerTime(offset)

        let items = items.map { item in
            let time = item.time + timeOffset
            return item.setTime(time)
        }

        return .init(timeBase: newTimeBase, items: items)
    }
}

extension TimeSeries: FixedDateTimeBased {
    public var timeBase: FixedDate { _timeBase }
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
    public
    mutating func updateTimeBase(_ timeBase: FixedDate) {
        guard _timeBase != timeBase else {
            return
        }

        assert(canUpdateTimeBase(to: timeBase))

        let offset = timeBase.millisecondsSince(_timeBase)
        _timeBase = timeBase

        let timeOffset = Element.IntegerTime(offset)

        for index in items.indices {
            let item = items[index]

            let time = item.time + timeOffset
            let updated = item.setTime(time)
            items[index] = updated
        }
    }

    public mutating func reserveCapacity(_ minimumCapacity: Int) {
        items.reserveCapacity(minimumCapacity)
    }

    public mutating
    func updateOrInsert(_ item: Self.Element) {
        let time = timeBase.adding(milliseconds: item.time)
        if let index = firstIndex(greaterOrEqual: time) {
            if items[index].time == item.time {
                items[index] = item
            } else {
                items.insert(item, at: index)
            }
        } else {
            items.append(item)
        }
    }
}
