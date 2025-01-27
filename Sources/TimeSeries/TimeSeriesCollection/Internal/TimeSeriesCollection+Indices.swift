//
//  TimeSeriesCollection+Indices.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 26.01.25.
//

internal
extension TimeSeriesCollection {
    func indices(for range: Range<FixedDate>) -> ClosedRange<Index>? {
        guard let lowerIndex = firstIndex(greaterOrEqual: range.lowerBound) else {
            return nil
        }

        guard let upperIndex = lastIndex(less: range.upperBound) else {
            return nil
        }

        return lowerIndex ... upperIndex
    }

    func indices(for range: ClosedRange<FixedDate>) -> ClosedRange<Index>? {
        guard let lowerIndex = firstIndex(greaterOrEqual: range.lowerBound) else {
            return nil
        }

        guard let upperIndex = lastIndex(lessOrEqual: range.upperBound) else {
            return nil
        }

        return lowerIndex ... upperIndex
    }

    func indices(for range: PartialRangeFrom<FixedDate>) -> ClosedRange<Index>? {
        guard let lowerIndex = firstIndex(greaterOrEqual: range.lowerBound) else {
            return nil
        }

        let upperIndex = index(before: endIndex)

        return lowerIndex ... upperIndex
    }

    func indices(for range: PartialRangeThrough<FixedDate>) -> ClosedRange<Index>? {
        let lowerIndex = startIndex

        guard let upperIndex = lastIndex(lessOrEqual: range.upperBound) else {
            return nil
        }

        return lowerIndex ... upperIndex
    }

    func indices(for range: PartialRangeUpTo<FixedDate>) -> ClosedRange<Index>? {
        let lowerIndex = startIndex

        guard let upperIndex = lastIndex(less: range.upperBound) else {
            return nil
        }

        return lowerIndex ... upperIndex
    }
}
