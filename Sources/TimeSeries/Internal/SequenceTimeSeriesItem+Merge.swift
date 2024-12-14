//
//  SequenceTimeSeriesItem+Merge.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 12.12.24.
//

extension Sequence where Self.Element: TimeSeriesItem {
    func merge<S: Sequence>(_ other: S) -> TimeSeriesItemsMergeSequence<Self, S> where Self.Element == S.Element {
        TimeSeriesItemsMergeSequence(left: self, right: other)
    }
}

struct TimeSeriesItemsMergeSequence<Left: Sequence, Right: Sequence>: Sequence
    where
    Left.Element: TimeSeriesItem,
    Left.Element == Right.Element
{
    typealias Element = Left.Element
    typealias Iterator = MergeIterator

    let left: Left
    let right: Right

    func makeIterator() -> Iterator {
        .init(left.makeIterator(), right.makeIterator())
    }
}

extension TimeSeriesItemsMergeSequence {
    struct MergeIterator: IteratorProtocol {
        typealias LeftIterator = Left.Iterator
        typealias RightIterator = Right.Iterator

        typealias Element = LeftIterator.Element

        var leftIterator: LeftIterator
        var rightIterator: RightIterator

        var left: Element?
        var right: Element?

        init(_ leftIterator: LeftIterator, _ rightIterator: RightIterator) {
            var leftIterator = leftIterator
            var rightIterator = rightIterator

            left = leftIterator.next()
            right = rightIterator.next()

            self.leftIterator = leftIterator
            self.rightIterator = rightIterator
        }

        mutating func next() -> Element? {
            if let left, let right {
                if left.time < right.time {
                    self.left = leftIterator.next()
                    return left
                }

                self.right = rightIterator.next()
                return right
            }

            if let left {
                self.left = leftIterator.next()
                return left
            }

            if let right {
                self.right = rightIterator.next()
                return right
            }

            return nil
        }
    }
}
