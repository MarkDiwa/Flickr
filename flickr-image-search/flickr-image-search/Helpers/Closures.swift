//
//  Closures.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

// Empty Result + Void Return
typealias EmptyResult<ReturnType> = () -> ReturnType

// Custom Result + Custom Return
typealias SingleResultWithReturn<T, ReturnType> = ((T) -> ReturnType)

// Custom Result + Void Return
typealias SingleResult<T> = SingleResultWithReturn<T, Void>

// Common
typealias VoidResult = EmptyResult<Void> // () -> Void
typealias ErrorResult = SingleResult<Error> // (Error) -> Void
typealias BoolResult = SingleResult<Bool> // (Bool) -> Void
