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
        let nextIndex = index(after: position)

        let leftRange = startIndex ..< position
        let midRange = position ..< nextIndex
        let rightRange = nextIndex ..< endIndex

        var result: [SubSequence] = []
        result.reserveCapacity(3)

        if !leftRange.isEmpty {
            result.append(self[leftRange].normalized())
        }

        return result
    }

    func split(_ time: FixedDate) -> [SubSequence] {
        let splitted: [SubSequence]

        if let index = firstIndex(greaterOrEqual: time) {
            splitted = [self[startIndex ..< index], self[index ..< endIndex].setTimeBase(time)]
        } else {
            if time < timeBase {
                splitted = [.empty.setTimeBase(timeBase), self[startIndex ..< endIndex]]
            } else if time > timeBase {
                splitted = [self[startIndex ..< endIndex], .empty.setTimeBase(timeBase)]
            } else {
                splitted = [self[startIndex ..< endIndex]]
            }
        }

        return splitted
    }
}
