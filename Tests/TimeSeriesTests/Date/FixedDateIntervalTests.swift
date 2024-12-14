//
//  FixedDateIntervalTests.swift
//  TimeSeries
//
//  Created by Vitali Kurlovich on 14.12.24.
//


import Testing
@testable import TimeSeries


@Test("FixedDateInterval")
func fixedDateInterval() throws {
    let strat = FixedDate(200)
    let end = FixedDate(400)

    let interval = FixedDateInterval(start: strat, end: end)
    
    
    #expect(interval.start == strat)
    #expect(interval.end == end)
    #expect(interval.duration == 200)
    
    #expect(interval.contains(strat))
    #expect(interval.contains(end))
    
    #expect(interval.contains( FixedDate(300)))
}

@Test("FixedDateInterval intersections")
func fixedDateIntervalIntersections() throws {
    
    let first = FixedDateInterval(start: FixedDate(200), end: FixedDate(400))
    let second = FixedDateInterval(start: FixedDate(210), end: FixedDate(410))
    
    #expect(first.intersects(second))
    #expect(second.intersects(first))
    
    #expect(first.intersection(with: second) == FixedDateInterval(start: FixedDate(200), end: FixedDate(410)))
    #expect(second.intersection(with: first) == FixedDateInterval(start: FixedDate(200), end: FixedDate(410)))
}

@Test("FixedDateInterval intersections")
func fixedDateIntervalIntersections_1() throws {
    
    let first = FixedDateInterval(start: FixedDate(200), end: FixedDate(400))
    let second = FixedDateInterval(start: FixedDate(500), end: FixedDate(600))
    
    #expect(first.intersects(second) == false)
    #expect(second.intersects(first)  == false)
    
    #expect(first.intersection(with: second) == nil)
    #expect(second.intersection(with: first) == nil)
}
