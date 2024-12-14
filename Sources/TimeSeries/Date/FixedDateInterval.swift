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
}

public
extension FixedDateInterval {
    init(start: FixedDate, end: FixedDate) {
        assert(start <= end)
        self.init(start: start, duration: end.millisecondsFrom1970 - start.millisecondsFrom1970)
    }
    
    var end: FixedDate {
        start.adding(milliseconds: duration)
    }
    
    func contains(_ date: FixedDate) -> Bool {
        let range = start.millisecondsFrom1970 ... end.millisecondsFrom1970
        
        return range.contains(date.millisecondsFrom1970)
    }
    
    func intersects(_ dateInterval: FixedDateInterval) -> Bool {
        self.contains(dateInterval.start) ||
        self.contains(dateInterval.end) ||
        dateInterval.contains(self.start) ||
        dateInterval.contains(self.end)
    }
    
    func intersection(with dateInterval: Self) -> Self? {
        guard self.intersects(dateInterval) else {
            return nil
        }
        
        let start = min(self.start, dateInterval.start)
        let end = max(self.end, dateInterval.end)
        return .init(start: start, end: end)
    }
    
}

public
extension DateInterval {
    init(_ interval: FixedDateInterval) {
        self.init(start: Date(interval.start), end: Date(interval.end))
    }
}
