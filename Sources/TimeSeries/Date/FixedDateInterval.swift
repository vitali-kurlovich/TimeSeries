//
//  FixedDateInterval.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 12.12.24.
//

import Foundation

public typealias FixedDateInterval = ClosedRange<FixedDate>

public
extension FixedDateInterval {
    var start: FixedDate {
        lowerBound
    }

    var end: FixedDate {
        upperBound
    }

    var duration: Int {
        start.millisecondsSince(end)
    }

    init(start: FixedDate, duration: Int) {
        assert(duration >= 0)
        self.init(start: start, end: start.adding(milliseconds: duration))
    }

    init(start: FixedDate, end: FixedDate) {
        assert(start <= end)
        self.init(uncheckedBounds: (lower: start, upper: end))
    }
}

public
extension FixedDateInterval {
    func intersection(with other: Self) -> Self? {
        guard intersects(other) else {
            return nil
        }

        let start = contains(other.start) ? other.start : self.start
        let end = contains(other.end) ? other.end : self.end
        return .init(start: start, end: end)
    }
}

public
extension FixedDateInterval {
    func union(_ other: Self) -> Self {
        .init(start: Swift.min(start, other.start), end: Swift.max(end, other.end))
    }
}

public
extension DateInterval {
    init(_ interval: FixedDateInterval) {
        self.init(start: Date(interval.start), end: Date(interval.end))
    }
}
