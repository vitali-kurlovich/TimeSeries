//
//  TimeSeriesCollection+Slice.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 24.01.25.
//

public
extension TimeSeriesCollection {
    subscript(_ range: Range<FixedDate>) -> Self.SubSequence? {
        guard let indices = indices(for: range) else {
            return nil
        }

        return self[indices]
    }

    subscript(_ range: ClosedRange<FixedDate>) -> Self.SubSequence? {
        guard let indices = indices(for: range) else {
            return nil
        }

        return self[indices]
    }

    subscript(_ range: PartialRangeFrom<FixedDate>) -> Self.SubSequence? {
        guard let indices = indices(for: range) else {
            return nil
        }

        return self[indices]
    }

    subscript(_ range: PartialRangeThrough<FixedDate>) -> Self.SubSequence? {
        guard let indices = indices(for: range) else {
            return nil
        }

        return self[indices]
    }

    subscript(_ range: PartialRangeUpTo<FixedDate>) -> Self.SubSequence? {
        guard let indices = indices(for: range) else {
            return nil
        }

        return self[indices]
    }
}
