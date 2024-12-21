//
//  FixedDateTimeBased.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 21.12.24.
//

public protocol FixedDateTimeBased {
    var timeBase: FixedDate { get }
}

public
extension FixedDateTimeBased where Self: RandomAccessCollection, Self.Element: IntegerTimeBased {
    var timeRange: FixedDateInterval? {
        if isEmpty {
            return nil
        }

        let start = dateTime(at: startIndex)
        let end = dateTime(at: index(before: endIndex))

        return FixedDateInterval(start: start, end: end)
    }

    func dateTime(at index: Index) -> FixedDate {
        let time = self[index].time
        return timeBase.adding(milliseconds: time)
    }
}
