//
//  TimeSeriesCollection+IndexByDate.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 25.01.25.
//

internal
extension TimeSeriesCollection {
    func index(with time: FixedDate) -> Index? {
        let minOffset = Int(TimeOffset.min)
        let maxOffset = Int(TimeOffset.max)

        let offset = timeBase.millisecondsSince(time)
        guard (minOffset ... maxOffset).contains(offset) else {
            return nil
        }

        return index(with: TimeOffset(offset))
    }
}
