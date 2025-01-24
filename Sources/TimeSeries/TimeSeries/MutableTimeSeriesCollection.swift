//
//  MutableTimeSeriesCollection.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 28.12.24.
//

public protocol MutableTimeSeriesCollection: TimeSeriesCollection {
    mutating func updateTimeBase(_ timeBase: FixedDate)

    mutating func reserveCapacity(_ minimumCapacity: Int)

    mutating
    func updateOrInsert(_ item: Self.Element)
}

public
extension MutableTimeSeriesCollection {
    var avalibleTimeRange: FixedDateInterval {
        let minTimeValue = Int(Self.Element.IntegerTime.min)
        let maxTimeValue = Int(Self.Element.IntegerTime.max)

        let start = timeBase.adding(milliseconds: minTimeValue)
        let end = timeBase.adding(milliseconds: maxTimeValue)

        return FixedDateInterval(start: Swift.max(timeBase, start), end: end)
    }

    func canUpdateTimeBase(to newTimeBase: FixedDate) -> Bool {
        canSetTimeBase(to: newTimeBase)
    }
}

extension TimeSeriesCollection {
    func canSetTimeBase(to newTimeBase: FixedDate) -> Bool {
        guard timeBase != newTimeBase, let last, let first else {
            return true
        }

        let offset = timeBase.millisecondsSince(newTimeBase)

        let minTimeValue = Int(Self.Element.IntegerTime.min)
        let maxTimeValue = Int(Self.Element.IntegerTime.max)

        let firstTime = Int(first.time) - offset
        let lastTime = Int(last.time) - offset

        return firstTime <= maxTimeValue &&
            lastTime <= maxTimeValue &&
            firstTime >= minTimeValue &&
            lastTime >= minTimeValue
    }
}
