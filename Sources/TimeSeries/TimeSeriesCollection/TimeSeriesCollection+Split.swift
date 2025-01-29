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
            if splitted.isEmpty {
                splitted.append(slice)
            } else {
                splitted.append(slice.normalized())
            }
        }

        let rande = startIndex ..< endIndex

        if !rande.isEmpty {
            let slice = self[rande]

            if splitted.isEmpty {
                splitted.append(slice)
            } else {
                splitted.append(slice.normalized())
            }
        }

        return splitted
    }
}

public
extension TimeSeriesCollection {
    func split(position: Self.Index) -> [SubSequence] {
        var result: [SubSequence] = []
        result.reserveCapacity(3)

        let leftRange = startIndex ..< position
        if !leftRange.isEmpty {
            result.append(self[leftRange])
        }

        let nextIndex = index(after: position)

        let midRange = position ..< nextIndex
        if !midRange.isEmpty {
            if result.isEmpty {
                result.append(self[midRange])
            } else {
                result.append(self[midRange].normalized())
            }
        }

        guard nextIndex < endIndex else {
            return result
        }

        let rightRange = nextIndex ..< endIndex
        result.append(self[rightRange].normalized())

        return result
    }

    func split(time: FixedDate) -> [SubSequence] {
        if let index = firstIndex(greaterOrEqual: time) {
            return split(position: index)
        } else {
            return []
        }
    }
}
