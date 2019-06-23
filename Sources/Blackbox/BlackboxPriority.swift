//
//  File.swift
//  
//
//  Created by Christian Ampe on 6/23/19.
//

import Foundation

public protocol BlackboxPriority: RawRepresentable, CustomStringConvertible, Equatable where Self.RawValue == Int {}
