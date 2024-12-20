//
//  TestTick.swift
//  Stocks
//
//  Created by Vitali Kurlovich on 20.12.24.
//

import TimeSeries

struct TestTick: IntegerTimeBased, Hashable, Sendable {
    let time: Int32
    let ask: Int
    let bid: Int

    func setTime(_ time: Int32) -> TestTick {
        .init(time: time, ask: ask, bid: bid)
    }
}
