//
//  MocTickConverter.swift
//  Stocks
//
//  Created by Vitali Kurlovich on 20.12.24.
//

import TimeSeries

struct MocTickConverter: TimeSeriesConverter {
    typealias Input = MocTick
    typealias Output = String

    func convert(date: FixedDate, input: Input) -> String {
        let milliseconds = date.millisecondsFrom1970

        return "\(milliseconds) [\(input.ask), \(input.bid)]"
    }
}
