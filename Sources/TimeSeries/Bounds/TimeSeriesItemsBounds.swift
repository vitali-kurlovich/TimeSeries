//
//  TimeSeriesItemsBounds.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 15.12.24.
//

public protocol TimeSeriesItemsBounds {
    var timeRange: FixedDateInterval { get }
    func union(_ other: Self) -> Self
}
