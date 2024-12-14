//
//  FixedDateInterval.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 12.12.24.
//

public struct FixedDateInterval: Hashable, Sendable {
    public let start: FixedDate
    public let duration: Int

    public init(start: FixedDate, duration: Int) {
        assert(duration >= 0)
        self.start = start
        self.duration = duration
    }
}

public
extension FixedDateInterval {
    init(start: FixedDate, end: FixedDate) {
        precondition(start <= end)

        self.init(start: start, duration: end.millisecondsFrom1970 - start.millisecondsFrom1970)
    }

    var end: FixedDate {
        start.adding(milliseconds: duration)
    }

    func contains(_ date: FixedDate) -> Bool {
        let range = start.millisecondsFrom1970 ... end.millisecondsFrom1970

        return range.contains(date.millisecondsFrom1970)
    }
}
