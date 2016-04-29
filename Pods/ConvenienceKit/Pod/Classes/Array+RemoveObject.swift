//
//  Array+RemoveObject.swift
//  ConvenienceKit
//
//  Created by Benjamin Encz on 4/17/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

import Foundation


public func removeObject<T : Equatable>(object: T, inout fromArray array: [T])
	{
        let index = array.indexOf(object)
    	  array.removeAtIndex(index!)
    }