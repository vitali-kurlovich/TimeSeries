//
//  TimeSeriesCollection+Normalized.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 13.12.24.
//

public
extension TimeSeriesCollection {
    func normalized() -> TimeSeries<Element> {
        if isEmpty {
            return .empty
        }

        let timeOffset = self[startIndex].time

        if timeOffset == 0 {
            return TimeSeries(self)
        }

        let items = items.map { item in
            let time = item.time - timeOffset
            return item.setTime(time)
        }

        let timeBase = timeBase.adding(milliseconds: timeOffset)

        return .init(timeBase: timeBase, items: items)
    }
}
