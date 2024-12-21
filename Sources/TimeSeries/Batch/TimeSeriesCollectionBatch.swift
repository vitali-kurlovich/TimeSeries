//
//  TimeSeriesCollectionBatch.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 21.12.24.
//

public protocol TimeSeriesCollectionBatch: RandomAccessCollection
    where
    Self.Element: TimeSeriesCollection,
    Self.SubSequence: TimeSeriesCollectionBatch
{
    associatedtype SubSequenceBatch: TimeSeriesCollectionBatch
    var timeRange: FixedDateInterval? { get }

    subscript(_: FixedDateInterval) -> SubSequenceBatch { get }
}
