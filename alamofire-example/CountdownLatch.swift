//
//  TaskCounter.swift
//  AFire
//
//  Created by Padraic Renaghan on 2/4/16.
//  Copyright © 2016 Renaghan. All rights reserved.
//

import Foundation

struct CountdownLatch {

  let group: dispatch_group_t

  init() {
    group = dispatch_group_create()
  }

  // indicate that an item has started that we need to wait on
  func add() {
    dispatch_group_enter(group)
  }

  // indicate that an item we are waiting on has finished
  func remove() {
    dispatch_group_leave(group)
  }

  // blocks current thread until all items are complete, may block forever
  func wait() {
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
  }

  // blocks current thread until all items are complete or timeout occurs
  // returns true if all items complete
  // returns false if timeout
  func wait(secondTimeout: Int64) -> Bool {
    let until = dispatch_time(DISPATCH_TIME_NOW, secondTimeout * 1000000000)
    return dispatch_group_wait(group, until) == 0
  }
}