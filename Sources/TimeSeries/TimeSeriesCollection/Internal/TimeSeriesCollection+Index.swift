//
//  TimeSeriesCollection+Index.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 24.01.25.
//

internal
extension TimeSeriesCollection {
    typealias TimeOffset = Self.Element.IntegerTime

    var timeOffsetAvalibleRange: ClosedRange<Int> {
        let minOffset = Int(TimeOffset.min)
        let maxOffset = Int(TimeOffset.max)

        return minOffset ... maxOffset
    }

    func index(with timeOffset: TimeOffset) -> Index? {
        guard let first, let last, (first.time ... last.time).contains(timeOffset) else { return nil }

        for index in indices {
            if self[index].time == timeOffset {
                return index
            }
        }

        return nil
    }
}

internal
extension TimeSeriesCollection {
    func firstIndex(withTimeOffsetGreaterThan timeOffset: TimeOffset) -> Index? {
        guard let first, let last, last.time > timeOffset else { return nil }

        if first.time > timeOffset {
            return startIndex
        }

        return partitioningIndex { item in
            timeOffset < item.time
        }
    }

    func firstIndex(withTimeOffsetGreaterOrEqualThan timeOffset: TimeOffset) -> Index? {
        guard let first, let last, last.time >= timeOffset else { return nil }

        if first.time >= timeOffset {
            return startIndex
        }

        return partitioningIndex { item in
            timeOffset <= item.time
        }
    }
}

internal
extension TimeSeriesCollection {
    func lastIndex(withTimeOffsetLessThan timeOffset: TimeOffset) -> Index? {
        guard let first, let last, first.time < timeOffset else { return nil }

        if last.time < timeOffset {
            return self.index(before: endIndex)
        }

        let index = partitioningIndex { item in
            !(item.time < timeOffset)
        }

        return self.index(before: index)
    }

    func lastIndex(withTimeOffsetLessOrEqualThan timeOffset: TimeOffset) -> Index? {
        guard let first, let last, first.time <= timeOffset else { return nil }

        if last.time <= timeOffset {
            return self.index(before: endIndex)
        }

        let index = partitioningIndex { item in
            !(item.time <= timeOffset)
        }

        return self.index(before: index)
    }
}
