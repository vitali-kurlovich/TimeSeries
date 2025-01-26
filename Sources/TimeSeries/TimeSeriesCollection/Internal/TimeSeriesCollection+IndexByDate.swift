//
//  TimeSeriesCollection+IndexByDate.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 25.01.25.
//

internal
extension TimeSeriesCollection {
    func index(with time: FixedDate) -> Index? {
        let offset = timeBase.millisecondsSince(time)

        guard timeOffsetAvalibleRange.contains(offset) else {
            return nil
        }

        return index(with: TimeOffset(offset))
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

/*

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

 */
