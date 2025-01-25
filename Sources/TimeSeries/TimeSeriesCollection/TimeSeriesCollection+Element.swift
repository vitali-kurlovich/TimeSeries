//
//  TimeSeriesCollection+Element.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 25.01.25.
//

public
extension TimeSeriesCollection {
    func element(at position: Index) -> (date: FixedDate, item: Element) {
        let item = self[position]
        let date = timeBase.adding(milliseconds: item.time)
        return (date: date, item: item)
    }

    func elements() -> TimeSeriesElements<Self> {
        .init(self)
    }
}

public
struct TimeSeriesElements<S: TimeSeriesCollection> {
    let collection: S

    public init(_ collection: S) {
        self.collection = collection
    }
}

extension TimeSeriesElements: Equatable where S: Equatable {}

extension TimeSeriesElements: Sendable where S: Sendable {}

extension TimeSeriesElements: RandomAccessCollection {
    public typealias Element = (date: FixedDate, item: S.Element)
    public typealias Index = S.Index
    public typealias Indices = S.Indices
    public typealias SubSequence = TimeSeriesElements<S.SubSequence>

    public var indices: Indices {
        collection.indices
    }

    public var startIndex: Index {
        collection.startIndex
    }

    public var endIndex: Index {
        collection.endIndex
    }

    public func index(before i: Index) -> Index {
        collection.index(before: i)
    }

    public func index(after i: Index) -> Index {
        collection.index(after: i)
    }

    public subscript(position: Index) -> Element {
        return collection.element(at: position)
    }

    public subscript(_ range: Range<Self.Index>) -> Self.SubSequence {
        SubSequence(collection[range])
    }
}
