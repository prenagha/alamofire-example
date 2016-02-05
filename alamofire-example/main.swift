import Alamofire
import SwiftyBeaver

// setup logging
let log = SwiftyBeaver.self
let console = ConsoleDestination()
console.colored = false
log.addDestination(console)

log.info("Start")

// keep track of response handler running async
let latch = CountdownLatch()

// run response handler async in their own queue
let queue = dispatch_queue_create("my.afire-queue", DISPATCH_QUEUE_CONCURRENT)

// tell latch we are about to fire off an async task we want to keep track of
latch.add()

Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
  .validate()
  .response(
    queue: queue,
    responseSerializer: Request.JSONResponseSerializer(options: .AllowFragments),
    completionHandler: { resp in
    if resp.result.isSuccess {
      log.info(resp.result.value)
    } else {
      log.error(resp.result.error)
    }
    // tell latch this async task is complete
    latch.remove()
  }
)

// block main thread until all our tasks are complete or 10s has passed
if latch.wait(10) {
  log.info("All tasks completed")
} else {
  log.error("ERROR Tasks did not complete")
}

log.info("End")
sleep(1)
