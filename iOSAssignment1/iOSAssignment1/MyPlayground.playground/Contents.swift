//: Playground - noun: a place where people can play

import UIKit

let tomorrow = Date(timeIntervalSinceNow: 87000)
let after = Date(timeIntervalSinceNow: 174000)


let dayAfter1 = Date(timeIntervalSinceNow: 174000)
let dayAfter2 = Date(timeIntervalSinceNow: 220000)
let dayAfter3 = Date(timeIntervalSinceNow: 340000)

Calendar.current.component(.hour, from: dayAfter1)