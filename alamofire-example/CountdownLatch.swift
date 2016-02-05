import Foundation

/**
 *  Simple countdown latch synchronization utility
 *  Commonly used to keep track of completion of background tasks
 */
struct CountdownLatch {

  /// Use dispatch group primitive
  let group: dispatch_group_t

  /**
   Create new instance

   - returns: new CountdownLatch
   */
  init() {
    group = dispatch_group_create()
  }

  /**
  Indicate that an item has started that we need to wait on
  */
  func add() {
    dispatch_group_enter(group)
  }

  /**
  Indicate that an item we are waiting on has finished
  */
  func remove() {
    dispatch_group_leave(group)
  }

  /**
  Block current thread until all items are complete, may block forever
  */
  func wait() {
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
  }

  /**
  Block current thread until all items are complete or timeout occurs

  - parameter secondTimeout: seconds to wait before timing out

  - returns: true if all items complete, false if timeout occurred
  */
  func wait(secondTimeout: Int64) -> Bool {
    let until = dispatch_time(DISPATCH_TIME_NOW, secondTimeout * 1000000000)
    return dispatch_group_wait(group, until) == 0
  }
}