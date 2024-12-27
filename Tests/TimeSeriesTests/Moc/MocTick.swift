//
//  MocTick.swift
//  Stocks
//
//  Created by Vitali Kurlovich on 20.12.24.
//

import TimeSeries

struct MocTick: IntegerTimeBased, Hashable, Sendable {
    let time: Int32
    let ask: Int
    let bid: Int

    func setTime(_ time: Int32) -> MocTick {
        .init(time: time, ask: ask, bid: bid)
    }
}
