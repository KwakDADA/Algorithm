import Foundation

func solution(_ absolutes:[Int], _ signs:[Bool]) -> Int {
    zip(absolutes, signs).map{$0.1 ? $0.0 : -$0.0}.reduce(0, +)
}