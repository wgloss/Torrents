//
//  Stream.swift
//  Torrents
//
//  Created by Salazar, Alexandros on 6/10/14.
//  Copyright (c) 2014 nomothetis. All rights reserved.
//

import Foundation

/*
 A stream generator generates the items of a sequence on demand.
 */
protocol Gen {
    typealias ItemType
    func next() -> ItemType
}

/*
A stream is a data structure that lazily computes its elements on demand. Traversal methods are
defined that allow .
*/
class Stream<T, G where G: Gen> {
    var generator:G
    var memoizedData:Array<T> = []
    init(theGenerator:G, memo:Array<T> = []) {
        self.generator = theGenerator
    }
}
