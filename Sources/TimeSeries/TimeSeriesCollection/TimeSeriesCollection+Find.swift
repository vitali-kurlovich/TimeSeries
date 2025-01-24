//
//  TimeSeriesCollection+Find.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 24.01.25.
//

public
extension TimeSeriesCollection {
    func firstIndex(withTimeOffsetGreaterThan time: Element.IntegerTime) -> Index {
        partitioningIndex { item in
            time < item.time
        }
    }

    func firstIndex(withTimeOffsetGreaterOrEqualThan time: Element.IntegerTime) -> Index {
        partitioningIndex { item in
            time <= item.time
        }
    }
}
