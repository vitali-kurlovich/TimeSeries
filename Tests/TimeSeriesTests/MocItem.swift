//
//  MocItem.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 12.12.24.
//

import TimeSeries

struct MocItem: TimeSeriesItem {
    typealias IntegerTime = Int32

    let time: Int32
    let index: Int

    func setTime(_ time: Int32) -> MocItem {
        MocItem(time: time, index: index)
    }
}
