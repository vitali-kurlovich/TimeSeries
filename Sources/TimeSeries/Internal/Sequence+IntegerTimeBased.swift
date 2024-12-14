//
//  Sequence+IntegerTimeBased.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 11.12.24.
//

extension Sequence where Self.Element: IntegerTimeBased {
    var isTimeValueIncrease: Bool {
        var iterator = makeIterator()

        guard var prev = iterator.next() else {
            return true
        }

        while let next = iterator.next() {
            guard prev.time < next.time else {
                return false
            }
            prev = next
        }
        return true
    }
}
