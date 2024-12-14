//
//  TimeSeriesCollection+Union.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 13.12.24.
//

public
extension TimeSeriesCollection {
    func union<S: TimeSeriesCollection>(_ other: S) -> TimeSeries<S.Element> where S.Element == Self.Element {
        if isEmpty, other.isEmpty {
            return .empty
        }

        let first = normalized()
        let second = other.normalized()

        if first.isEmpty {
            return second
        }

        if second.isEmpty {
            return first
        }

        guard first.timeBase <= second.timeBase else {
            return second.union(first)
        }

        let delta = first.timeBase.millisecondsSince(second.timeBase)
        let increment = Element.IntegerTime(delta)

        let secondItems = second.items.lazy.map { item in
            let time = item.time + increment
            return item.setTime(time)
        }

        let items = first.items.merge(secondItems).removeDuplicates()

        return TimeSeries(timeBase: first.timeBase, items: Array(items))
    }
}
