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
protocol Generator {
    typealias GeneratorType
    func next() -> GeneratorType
}

/*
 A map generator is a class that represents mapping over a generator.
 */
class MapGenerator<P, G where G: Generator>:Generator {
    typealias ItemType = P
    let baseGenerator:G
    let mapFunction:G.GeneratorType -> P
    
    init(baseGenerator:G, f:G.GeneratorType -> P) {
        self.baseGenerator = baseGenerator
        self.mapFunction = f
    }
    
    func next() -> P {
        return self.mapFunction(self.baseGenerator.next())
    }
}

/*
A stream is a data structure that lazily computes its elements on demand. Traversal methods are
defined that allow .
*/
class Stream<T, G where G: Generator> {
    let generator:G
    var memoizedData:Array<G.GeneratorType>
    init(theGenerator:G, memo:Array<G.GeneratorType> = []) {
        self.generator = theGenerator
        self.memoizedData = memo
    }
    
    func map<P>(f:G.GeneratorType -> P) -> Stream<P, G> {
        var memoizedMap = memoizedData.map(f)
        return Stream(MapGenerator(self.generator, f), memoizedMap)
    }
}
