//
//  TimeSeriesCollection+Split.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 24.01.25.
//

public
extension TimeSeriesCollection {
    func split(maxCount: Int) -> [SubSequence] {
        assert(maxCount > 0)
        var splitted: [SubSequence] = []
        splitted.reserveCapacity(1 + count / maxCount)

        var startIndex = self.startIndex

        for endIndex in indices.striding(by: maxCount).dropFirst() {
            let rande = startIndex ..< endIndex
            startIndex = endIndex

            let slice = self[rande]
            splitted.append(slice)
        }

        let rande = startIndex ..< endIndex

        if !rande.isEmpty {
            let slice = self[rande]
            splitted.append(slice)
        }

        return splitted
    }
}

public
extension TimeSeriesCollection {
    func split(_ time: FixedDate, omittingEmptySubsequences: Bool = true) -> [SubSequence] {
        if timeBase == time {
            return [self[startIndex ..< endIndex]]
        }

        if omittingEmptySubsequences {
            return splitOmittingEmpty(time)
        }

        guard let timeRange else {
            let empty: SubSequence = .empty
            return [empty.setTimeBase(time)]
        }

        if time == timeRange.start {
            return [self[startIndex ..< endIndex]]
        }

        if time == timeRange.end {
            return [self[startIndex ..< endIndex], .empty.setTimeBase(time)]
        }

        if timeRange.contains(time) {
            let end = partitioningIndex { item in
                let date = timeBase.adding(milliseconds: item.time)
                return date > time
            }

            return [self[startIndex ..< end], self[end ..< endIndex]]
        }

        return []
    }

    private func splitOmittingEmpty(_ time: FixedDate) -> [SubSequence] {
        guard let timeRange else {
            return []
        }

        if time <= timeRange.start || time >= timeRange.end {
            return [self[startIndex ..< endIndex]]
        }

        let end = partitioningIndex { item in
            let date = timeBase.adding(milliseconds: item.time)
            return date > time
        }

        return [self[startIndex ..< end], self[end ..< endIndex]]
    }
}
