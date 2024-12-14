//
//  SequenceTimeSeriesItem+RemoveDuplicates.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 13.12.24.
//

extension Sequence where Self.Element: TimeSeriesItem {
    func removeDuplicates() -> TimeSeriesItemsRemoveDuplicatesSequence<Self> {
        TimeSeriesItemsRemoveDuplicatesSequence(sequence: self)
    }
}

struct TimeSeriesItemsRemoveDuplicatesSequence<S: Sequence>: Sequence where S.Element: TimeSeriesItem {
    typealias Element = S.Element
    typealias Iterator = RemoveDuplicatesIterator

    let sequence: S

    func makeIterator() -> Iterator {
        Iterator(sequence.makeIterator())
    }
}

extension TimeSeriesItemsRemoveDuplicatesSequence {
    struct RemoveDuplicatesIterator: IteratorProtocol where S.Element: TimeSeriesItem {
        typealias Element = S.Element

        var last: Element?
        var iterator: S.Iterator

        init(_ iterator: S.Iterator) {
            var iterator = iterator
            last = iterator.next()
            self.iterator = iterator
        }

        mutating func next() -> Element? {
            if last == nil {
                return nil
            }

            while let next = iterator.next() {
                if last?.time != next.time {
                    defer {
                        self.last = next
                    }
                    return last
                }
            }

            defer {
                self.last = nil
            }

            return last
        }
    }
}
