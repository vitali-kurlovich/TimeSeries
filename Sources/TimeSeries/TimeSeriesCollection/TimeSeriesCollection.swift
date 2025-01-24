//
//  TimeSeriesCollection.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 13.12.24.
//

import Algorithms

public protocol TimeSeriesCollection: RandomAccessCollection, FixedDateTimeBased
    where Element: TimeSeriesItem,
    SubSequence: TimeSeriesCollection
{
    static var empty: Self { get }
    func setTimeBase(_ newTimeBase: FixedDate) -> Self
}
