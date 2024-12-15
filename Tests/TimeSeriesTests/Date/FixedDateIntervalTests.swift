//
//  FixedDateIntervalTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 14.12.24.
//

import Testing
@testable import TimeSeries

struct FixedDateIntervalTests {
    @Test("Contains")
    func contains() throws {
        let strat = FixedDate(200)
        let end = FixedDate(400)

        let interval = FixedDateInterval(start: strat, end: end)

        #expect(interval.start == strat)
        #expect(interval.end == end)
        #expect(interval.duration == 200)

        #expect(interval.contains(strat))
        #expect(interval.contains(end))

        #expect(interval.contains(FixedDate(300)))
    }

    @Test("Intersection")
    func intersections() throws {
        let first = FixedDateInterval(start: FixedDate(200), end: FixedDate(400))
        let second = FixedDateInterval(start: FixedDate(210), end: FixedDate(410))

        #expect(first.intersects(second))
        #expect(second.intersects(first))

        #expect(first.intersection(with: second) == FixedDateInterval(start: FixedDate(210), end: FixedDate(400)))
        #expect(first.intersection(with: second) == second.intersection(with: first))

        #expect(first.intersection(with: first) == first)
    }

    @Test("Empty intersection")
    func emptyIntersections() throws {
        let first = FixedDateInterval(start: FixedDate(200), end: FixedDate(400))
        let second = FixedDateInterval(start: FixedDate(500), end: FixedDate(600))

        #expect(first.intersects(second) == false)
        #expect(second.intersects(first) == false)

        #expect(first.intersection(with: second) == nil)
        #expect(second.intersection(with: first) == nil)
    }

    @Test("Union")
    func union() throws {
        let first = FixedDateInterval(start: FixedDate(200), end: FixedDate(400))
        let second = FixedDateInterval(start: FixedDate(210), end: FixedDate(410))

        #expect(first.union(second) == FixedDateInterval(start: FixedDate(200), end: FixedDate(410)))
        #expect(first.union(second) == second.union(first))

        #expect(first.union(first) == first)

        let third = FixedDateInterval(start: FixedDate(600), end: FixedDate(800))

        #expect(first.union(third) == FixedDateInterval(start: FixedDate(200), end: FixedDate(800)))
        #expect(first.union(third) == third.union(first))
    }
}
