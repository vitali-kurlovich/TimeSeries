//
//  MocItem.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 12.12.24.
//

import TimeSeries

struct MocItem: TimeSeriesItem {
    typealias IntegerTime = Int16

    let time: IntegerTime
    let index: Int

    func setTime(_ time: IntegerTime) -> MocItem {
        MocItem(time: time, index: index)
    }
}
