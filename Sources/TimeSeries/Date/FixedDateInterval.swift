//
//  FixedDateInterval.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 12.12.24.
//

import Foundation

public struct FixedDateInterval: Hashable, Sendable {
    public let start: FixedDate
    public let duration: Int

    public init(start: FixedDate, duration: Int) {
        assert(duration >= 0)
        self.start = start
        self.duration = duration
    }

    public init(start: FixedDate, end: FixedDate) {
        assert(start <= end)
        self.init(start: start, duration: end.millisecondsFrom1970 - start.millisecondsFrom1970)
    }
}

public
extension FixedDateInterval {
    var end: FixedDate {
        start.adding(milliseconds: duration)
    }

    func contains(_ date: FixedDate) -> Bool {
        let range = start.millisecondsFrom1970 ... end.millisecondsFrom1970

        return range.contains(date.millisecondsFrom1970)
    }
}

public
extension FixedDateInterval {
    func intersects(_ dateInterval: FixedDateInterval) -> Bool {
        contains(dateInterval.start) ||
            contains(dateInterval.end) ||
            dateInterval.contains(start) ||
            dateInterval.contains(end)
    }

    func intersection(with other: Self) -> Self? {
        guard intersects(other) else {
            return nil
        }

        if contains(other.start) {}

        let start = contains(other.start) ? other.start : self.start
        let end = contains(other.end) ? other.end : self.end
        return .init(start: start, end: end)
    }
}

public
extension FixedDateInterval {
    func union(_ other: Self) -> Self {
        .init(start: min(start, other.start), end: max(end, other.end))
    }
}

public
extension DateInterval {
    init(_ interval: FixedDateInterval) {
        self.init(start: Date(interval.start), end: Date(interval.end))
    }
}
