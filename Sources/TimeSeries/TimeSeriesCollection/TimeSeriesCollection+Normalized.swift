//
//  TimeSeriesCollection+Normalized.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 13.12.24.
//

public
extension TimeSeriesCollection {
    func normalized() -> Self {
        if isEmpty {
            return self
        }
        let timeOffset = self[startIndex].time
        let timeBase = timeBase.adding(milliseconds: timeOffset)
        return setTimeBase(timeBase)
    }
}
