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
 A generator that takes a function and an existing generator and applies the function to the
 existing generator's return values.
 */
protocol MapGen {
    typealias MapGeneratorType
    let generator:Gen
    func next() -> MapGeneratorType
}

class MapGenImpl<T, P> : MapGen {
    typealias ItemType = T
    typealias MapGeneratorType = P
    let f:T -> P
    let generator:Gen
    
    init(baseGenerator:Gen, mapFunction:T -> P) {
        self.generator = baseGenerator
        self.f = mapFunction
    }
    
    func next() -> P  {
        return self.f(self.generator.next())
    }
}

/*
A stream is a data structure that lazily computes its elements on demand. Traversal methods are
defined that allow .
*/
class Stream<T> {
    typealias ItemType = T
    var generator:Gen
    var memoizedData:Array<T> = []
    init(generator:Gen, memo:Array<T> = []) {
        self.generator = generator
        var next = self.generator.next()
    }
    
    func map<P>(f:T -> P) -> Stream<P> {
        /* Take care of the base case. */
        var preStream = memoizedData.map(f)
        
        /* Create a new generator based on the existing generator. */
        var newGenerator = nil
        
    }
}
