//
//  TimeSeriesCollection+Find.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 24.01.25.
//

extension TimeSeriesCollection {
    func firstIndex(withTimeOffsetGreaterThan timeOffset: Element.IntegerTime) -> Index? {
        guard let first, let last, last.time > timeOffset else { return nil }

        if first.time > timeOffset {
            return startIndex
        }

        return partitioningIndex { item in
            timeOffset < item.time
        }
    }

    func firstIndex(withTimeOffsetGreaterOrEqualThan timeOffset: Element.IntegerTime) -> Index? {
        guard let first, let last, last.time >= timeOffset else { return nil }

        if first.time >= timeOffset {
            return startIndex
        }

        return partitioningIndex { item in
            timeOffset <= item.time
        }
    }
}

extension TimeSeriesCollection {
    func lastIndex(withTimeOffsetLessThan timeOffset: Element.IntegerTime) -> Index? {
        guard let first, let last, first.time < timeOffset else { return nil }

        if last.time < timeOffset {
            return self.index(before: endIndex)
        }

        let index = partitioningIndex { item in
            !(item.time < timeOffset)
        }

        return self.index(before: index)
    }

    func lastIndex(withTimeOffsetLessOrEqualThan timeOffset: Element.IntegerTime) -> Index? {
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
