//
//  TimeSeriesCollection+Index.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 24.01.25.
//

internal
extension TimeSeriesCollection {
    func index(with time: FixedDate) -> Index? {
        for index in indices {
            let item = self[index]
            let date = timeBase.adding(milliseconds: item.time)

            if date == time {
                return index
            }
        }

        return nil
    }
}

internal
extension TimeSeriesCollection {
    func firstIndex(greater time: FixedDate) -> Index? {
        guard let timeRange, timeRange.end > time else {
            return nil
        }

        if timeRange.start > time {
            return startIndex
        }

        let timeBase = self.timeBase

        return partitioningIndex { item in
            let date = timeBase.adding(milliseconds: item.time)
            return time < date
        }
    }

    func firstIndex(greaterOrEqual time: FixedDate) -> Index? {
        guard let timeRange, timeRange.end >= time else {
            return nil
        }

        if timeRange.start >= time {
            return startIndex
        }

        let timeBase = self.timeBase

        return partitioningIndex { item in
            let date = timeBase.adding(milliseconds: item.time)
            return time <= date
        }
    }
}

internal
extension TimeSeriesCollection {
    func lastIndex(less time: FixedDate) -> Index? {
        guard let timeRange, timeRange.start < time else {
            return nil
        }

        if timeRange.end < time {
            return index(before: endIndex)
        }

        let timeBase = self.timeBase

        let index = partitioningIndex { item in
            let date = timeBase.adding(milliseconds: item.time)
            return !(date < time)
        }

        return self.index(before: index)
    }

    func lastIndex(lessOrEqual time: FixedDate) -> Index? {
        guard let timeRange, timeRange.start <= time else {
            return nil
        }

        if timeRange.end <= time {
            return index(before: endIndex)
        }

        let timeBase = self.timeBase

        let index = partitioningIndex { item in
            let date = timeBase.adding(milliseconds: item.time)
            return !(date <= time)
        }

        return self.index(before: index)
    }
}
